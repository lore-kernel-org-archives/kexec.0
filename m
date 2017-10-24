Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e6rx4-0001V4-5u
 for kexec@lists.infradead.org; Tue, 24 Oct 2017 05:40:35 +0000
Message-Id: <20171024053147.493545734@redhat.com>
Date: Tue, 24 Oct 2017 13:31:47 +0800
From: dyoung@redhat.com
Subject: [PATCH 0/3] kdump: crashkernel parameter improvement
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, corbet@lwn.net, yinghai@kernel.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

Hi,

Here is a try to improve current crashkernel kernel parameter

Patch 1/3 adds an extra functionality so that one can use like
crashkernel=2G-:128M^12 to reserve 128M for 2G+ machine but also scale the
size based on system memory, that means 128M + (total_mem - 128M) >> 12

Patch 2/3 is a resending of previous post to let crashkernel=xM to reserve
first from below 896M, then <4G, then <MAXMEM

Patch 3/3 round up total system memory size because according to test the
mem size from memblock api is usually smaller than actual size, this passed
my tests on x86/arm/powerpc, it should work for most cases, but there might 
be exceptions, appreciated for any better idea.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
