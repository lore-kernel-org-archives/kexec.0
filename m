Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wi20A-0005t2-FH
 for kexec@lists.infradead.org; Wed, 07 May 2014 13:35:15 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [RFC PATCH 0/2] transfer sparse memory related values
Date: Wed, 7 May 2014 21:27:12 +0800
Message-ID: <1399469234-54925-1-git-send-email-sdu.liu@huawei.com>
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
To: linux@arm.linux.org.uk, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: wangnan0@huawei.com, peifeiyue@huawei.com, sdu.liu@huawei.com, will.deacon@arm.com, liusdu@126.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Now different platforms may have different SECTION_SIZE_BITS and
MAX_PHYSMEM_BITS. But linux passes nothing related to the 
vmcore.

User space tools such as makedumpfile needs these to deal with 
the vmcore. So we must define these when compiling. So if we 
deal with aother vmcore. We may need to recompile the tools.

These patch series make kernel pass related infomation to
the user space tools, via vmcore. And makedumpfile can
get these when parsing vmcore. So the makdumpfile becomes
more compatible to vmcore with different section size.


Liu Hua (1):
  kdump: add sparse memory related values to vmcore
  makedumpfile: get additional information from vmcore

 kernel/kexec.c | 3 +++
 makedumpfile.c | 17 +++++++++++++++++
 makedumpfile.h |  2 ++
 3 files changed, 22 insertions(+)

-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
