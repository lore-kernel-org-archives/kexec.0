Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtYJa-0007H8-L5
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 06:42:07 +0000
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 11 Jan 2013 12:10:25 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8F9DC3940051
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 12:11:59 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0B6fwgS39649290
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 12:11:58 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0B6fwlf024615
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 06:41:59 GMT
Subject: [PATCH 2/3] kexec/uImage: Recognize uImage RAM Disks
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Fri, 11 Jan 2013 12:11:58 +0530
Message-ID: <20130111064141.11490.47786.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: bigeasy@linutronix.de, lethal@linux-sh.org, kexec@lists.infradead.org, mat@brain-dump.org

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Add IH_TYPE_RAMDISK as a recognized image type.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/kexec-uImage.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index dcbd635..701eeb1 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -52,6 +52,8 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 			return -1;
 		}
 		break;
+	case IH_TYPE_RAMDISK:
+		break;
 	default:
 		printf("uImage type %d unsupported\n", header.ih_type);
 		return -1;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
