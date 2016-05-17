Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b2lJw-0006vF-R7
 for kexec@lists.infradead.org; Tue, 17 May 2016 20:10:25 +0000
Received: by mail-pf0-x242.google.com with SMTP id b66so2831816pfb.2
 for <kexec@lists.infradead.org>; Tue, 17 May 2016 13:10:04 -0700 (PDT)
From: minyard@acm.org
Subject: [PATCH] kdump: Fix dmesg gdbmacro to work with record based printk
Date: Tue, 17 May 2016 15:09:54 -0500
Message-Id: <1463515794-1599-1-git-send-email-minyard@acm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Change 7ff9554bb578ba02166071d2d487b7fc7d860d62 introduced a record
based printk buffer.  Modify gdbmacros.txt to parse this new structure
so dmesg will work properly.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 Documentation/kdump/gdbmacros.txt | 93 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
index 9b9b454..7c590fb 100644
--- a/Documentation/kdump/gdbmacros.txt
+++ b/Documentation/kdump/gdbmacros.txt
@@ -178,21 +178,92 @@ document trapinfo
 	address the kernel panicked.
 end
 
+define dump_log_idx
+	set $idx = $arg0
+	if ($argc > 1)
+		set $prev_flags = $arg1
+	else
+		set $prev_flags = 0
+	end
+	set $msg = ((struct printk_log *) (log_buf + $idx))
+	set $prefix = 1
+	set $newline = 1
+	set $log = log_buf + $idx + sizeof(*$msg)
 
-define dmesg
-	set $i = 0
-	set $end_idx = (log_end - 1) & (log_buf_len - 1)
+	# prev & LOG_CONT && !(msg->flags & LOG_PREIX)
+	if (($prev_flags & 8) && !($msg->flags & 4))
+		set $prefix = 0
+	end
+
+	# msg->flags & LOG_CONT
+	if ($msg->flags & 8)
+		# (prev & LOG_CONT && !(prev & LOG_NEWLINE))
+		if (($prev_flags & 8) && !($prev_flags & 2))
+			set $prefix = 0
+		end
+		# (!(msg->flags & LOG_NEWLINE))
+		if (!($msg->flags & 2))
+			set $newline = 0
+		end
+	end
+
+	if ($prefix)
+		printf "[%5lu.%06lu] ", $msg->ts_nsec / 1000000000, $msg->ts_nsec % 1000000000
+	end
+	if ($msg->text_len != 0)
+		eval "printf \"%%%d.%ds\", $log", $msg->text_len, $msg->text_len
+	end
+	if ($newline)
+		printf "\n"
+	end
+	if ($msg->dict_len > 0)
+		set $dict = $log + $msg->text_len
+		set $idx = 0
+		set $line = 1
+		while ($idx < $msg->dict_len)
+			if ($line)
+				printf " "
+				set $line = 0
+			end
+			set $c = $dict[$idx]
+			if ($c == '\0')
+				printf "\n"
+				set $line = 1
+			else
+				if ($c < ' ' || $c >= 127 || $c == '\\')
+					printf "\\x%02x", $c
+				else
+					printf "%c", $c
+				end
+			end
+			set $idx = $idx + 1
+		end
+		printf "\n"
+	end
+end
+document dump_log_idx
+	Dump a single log given its index in the log buffer.  The first
+	parameter is the index into log_buf, the second is optional and
+	specified the previous log buffer's flags, used for properly
+	formatting continued lines.
+end
 
-	while ($i < logged_chars)
-		set $idx = (log_end - 1 - logged_chars + $i) & (log_buf_len - 1)
+define dmesg
+	set $i = log_first_idx
+	set $end_idx = log_first_idx
+	set $prev_flags = 0
 
-		if ($idx + 100 <= $end_idx) || \
-		   ($end_idx <= $idx && $idx + 100 < log_buf_len)
-			printf "%.100s", &log_buf[$idx]
-			set $i = $i + 100
+	while (1)
+		set $msg = ((struct printk_log *) (log_buf + $i))
+		if ($msg->len == 0)
+			set $i = 0
 		else
-			printf "%c", log_buf[$idx]
-			set $i = $i + 1
+			dump_log_idx $i $prev_flags
+			set $i = $i + $msg->len
+			set $prev_flags = $msg->flags
+		end
+		if ($i == $end_idx)
+			loop_break
 		end
 	end
 end
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
