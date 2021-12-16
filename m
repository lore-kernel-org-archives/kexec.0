Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxpBE-005Fzx-KB
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 11:44:15 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 3/5] add slurp_proc_file()
Date: Thu, 16 Dec 2021 12:43:54 +0100
Message-Id: <20211216114356.605851-4-svens@linux.ibm.com>
In-Reply-To: <20211216114356.605851-1-svens@linux.ibm.com>
References: <20211216114356.605851-1-svens@linux.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, prudo@redhat.com, Sven Schnelle <svens@linux.ibm.com>

slurp_file() cannot be used to read proc files, as they are returning
a size of zero in stat(). Add a function slurp_proc_file() which is
similar to slurp_file(), but doesn't require the size of the file to
be known.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kexec/kexec.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f63b36b771eb..f3adac517161 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1106,6 +1106,57 @@ static void remove_parameter(char *line, const char *param_name)
 	}
 }
 
+static ssize_t _read(int fd, void *buf, size_t count)
+{
+	ssize_t ret, offset = 0;
+
+	do {
+		ret = read(fd, buf + offset, count - offset);
+		if (ret < 0) {
+			if ((errno == EINTR) ||	(errno == EAGAIN))
+				continue;
+			return ret;
+		}
+		offset += ret;
+	} while (ret && offset < count);
+
+	return offset;
+}
+
+static char *slurp_proc_file(const char *filename, size_t *len)
+{
+	ssize_t ret, startpos = 0;
+	unsigned int size = 64;
+	char *buf = NULL, *tmp;
+	int fd;
+
+	fd = open(filename, O_RDONLY);
+	if (fd == -1)
+		return NULL;
+
+	do {
+		size *= 2;
+		tmp = realloc(buf, size);
+		if (!tmp) {
+			free(buf);
+			return NULL;
+		}
+		buf = tmp;
+
+		ret = _read(fd, buf + startpos, size - startpos);
+		if (ret < 0) {
+			free(buf);
+			return NULL;
+		}
+
+		startpos += ret;
+
+	} while(ret);
+
+	*len = startpos;
+	return buf;
+}
+
 /*
  * Returns the contents of the current command line to be used with
  * --reuse-cmdline option.  The function gets called from architecture specific
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
