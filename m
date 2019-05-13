Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQ5SH-0003aZ-OV
 for kexec@lists.infradead.org; Mon, 13 May 2019 07:33:03 +0000
Date: Mon, 13 May 2019 15:32:54 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190513073254.GB16774@MiWiFi-R3L-srv>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190513070725.GA20105@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: fanc.fnst@cn.fujitsu.com, kasong@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, j-nomura@ce.jp.nec.com, tglx@linutronix.de, dyoung@redhat.com

On 05/13/19 at 09:07am, Borislav Petkov wrote:
> Baoquan,
> 
> On Mon, May 13, 2019 at 09:43:05AM +0800, Baoquan He wrote:
> > Can this patchset be merged, or picked into tip?
> 
> what is this thing that happens everytime after a kernel is released and
> lasts for approximately 2 weeks?

This is a critical bug which breaks memory hotplug, since KASLR is
enabled by default in upstream, and in our distros too. You can see that
Junichi posted the patch after NEC must have tested the code and found
the new issue. And Chao from FJ also worked out the patches to fix the bug. 
And I have tracking  bugs at hand from other important customers, related
to this fix too. The back porting of Chao's patches into our distros are
blocked by these two. We gonna miss another due date we promised to customers.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
