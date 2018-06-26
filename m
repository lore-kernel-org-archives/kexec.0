Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fXtwk-0004vj-5m
 for kexec@lists.infradead.org; Tue, 26 Jun 2018 19:48:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with
 ESMTP id w5QJlw75036112
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 26 Jun 2018 19:48:02 GMT
From: Munehisa Kamata <kamatam@amazon.com>
Subject: [PATCH 2/2] arm64: error out if kernel command line is too long
Date: Tue, 26 Jun 2018 12:47:29 -0700
Message-ID: <1530042449-19329-2-git-send-email-kamatam@amazon.com>
In-Reply-To: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
References: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
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
To: kexec@lists.infradead.org
Cc: Munehisa Kamata <kamatam@amazon.com>

Currently, in arm64, kexec silently truncates kernel command line longer
than COMMAND_LINE_SIZE - 1. Error out in that case as some other
architectures already do that. The error message is copied from x86_64.

Suggested-by: Tom Kirchner <tjk@amazon.com>
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---
 kexec/arch/arm64/kexec-arm64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 62f3758..8200064 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -536,8 +536,15 @@ int arm64_load_other_segments(struct kexec_info *info,
 	char command_line[COMMAND_LINE_SIZE] = "";
 
 	if (arm64_opts.command_line) {
+		if (strlen(arm64_opts.command_line) >
+		    sizeof(command_line) - 1) {
+			fprintf(stderr,
+				"Kernel command line too long for kernel!\n");
+			return EFAILED;
+		}
+
 		strncpy(command_line, arm64_opts.command_line,
-			sizeof(command_line));
+			sizeof(command_line) - 1);
 		command_line[sizeof(command_line) - 1] = 0;
 	}
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
