Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmwT8-001NCU-Uc
 for kexec@lists.infradead.org; Tue, 16 Nov 2021 11:17:44 +0000
Date: Tue, 16 Nov 2021 12:17:35 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 RESEND 2/2] s390/kexec: fix memory leak of ipl report
 buffer
Message-ID: <YZOTT2v+V14Nk7IB@osiris>
References: <20211116032557.14075-1-bhe@redhat.com>
 <20211116032557.14075-2-bhe@redhat.com>
 <20211116033101.GD21646@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211116033101.GD21646@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, prudo@redhat.com

On Tue, Nov 16, 2021 at 11:31:01AM +0800, Baoquan He wrote:
> unreferenced object 0x38000195000 (size 4096):
>   comm "kexec", pid 8548, jiffies 4294953647 (age 32443.270s)
>   hex dump (first 32 bytes):
>     00 00 00 c8 20 00 00 00 00 00 00 c0 02 80 00 00  .... ...........
>     40 40 40 40 40 40 40 40 00 00 00 00 00 00 00 00  @@@@@@@@........
>   backtrace:
>     [<0000000011a2f199>] __vmalloc_node_range+0xc0/0x140
>     [<0000000081fa2752>] vzalloc+0x5a/0x70
>     [<0000000063a4c92d>] ipl_report_finish+0x2c/0x180
>     [<00000000553304da>] kexec_file_add_ipl_report+0xf4/0x150
>     [<00000000862d033f>] kexec_file_add_components+0x124/0x160
>     [<000000000d2717bb>] arch_kexec_kernel_image_load+0x62/0x90
>     [<000000002e0373b6>] kimage_file_alloc_init+0x1aa/0x2e0
>     [<0000000060f2d14f>] __do_sys_kexec_file_load+0x17c/0x2c0
>     [<000000008c86fe5a>] __s390x_sys_kexec_file_load+0x40/0x50
>     [<000000001fdb9dac>] __do_syscall+0x1bc/0x1f0
>     [<000000003ee4258d>] system_call+0x78/0xa0
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to next kernel")
> ---
> RESEND:
>   Fix the incorrect subject.
> 
>  arch/s390/include/asm/kexec.h         | 7 +++++++
>  arch/s390/kernel/machine_kexec_file.c | 9 +++++++++
>  2 files changed, 16 insertions(+)

Applied, thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
