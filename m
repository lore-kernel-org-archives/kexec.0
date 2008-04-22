Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wr-out-0506.google.com ([64.233.184.225])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRzN-00070N-Ec
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:29 +0000
Received: by wr-out-0506.google.com with SMTP id c46so2299713wra.18
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:28 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 9/9] Die on early EOF in slurp_file,
	instead of infinite-looping.
Date: Tue, 22 Apr 2008 16:21:12 -0700
Message-Id: <1208906472-18465-10-git-send-email-jamey@thetovacompany.com>
In-Reply-To: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
A "shouldn't happen" case that I triggered due to a different bug in
Windows. I thought that, in the unlikely event that this case occurs, an
infinite loop is a rather harsh result.

 kexec/kexec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 3a1656a..f898428 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -408,6 +408,8 @@ char *slurp_file(const char *filename, off_t *r_size)
 			die("read on %s of %ld bytes failed: %s\n", filename,
 			    (size - progress)+ 0UL, strerror(errno));
 		}
+		if (result == 0)
+			die("read on %s ended before stat said it should\n", filename);
 		progress += result;
 	}
 	result = close(fd);
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
