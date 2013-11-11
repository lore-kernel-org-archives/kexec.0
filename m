Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VfyUm-0004c8-QZ
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 20:54:05 +0000
Date: Mon, 11 Nov 2013 15:53:41 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Kexec query about what makes sure control pages/page tables are not
 overwritten
Message-ID: <20131111205341.GE11547@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Yinghai Lu <yinghai@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

Hi,

I am staring at control page allocation logic in case of kdump and
wondering what makes sure that these pages are not overwritten by 
next kernel.

I see that for 64bit entry, control pages have the page tables needed
for second kernel. In case of crash these pages from from crash kernel
reserved region. Page allocator is very simple and that is start from
lowest crash reserved range and move higher and allocate first available
page which is not allocated to segments. What makes sure that these pages
are not overwritten by second kernel.

I guess it becomes a general bootloader question. How do we make sure
bootloader prepared page tables/gdt will not be overwritten by kernel
(till kernel sets up its own page tables and gdt) and how should we do the
allocation and placement.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
