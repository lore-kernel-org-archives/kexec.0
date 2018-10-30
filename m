Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHQGB-0001VU-OF
 for kexec@lists.infradead.org; Tue, 30 Oct 2018 09:24:28 +0000
Date: Tue, 30 Oct 2018 17:23:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181030092314.GC14493@MiWiFi-R3L-srv>
References: <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181030091542.GD32102@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de


Hi Boris, DaveY and Lianbo,

On 10/30/18 at 10:15am, Borislav Petkov wrote:
> On Tue, Oct 30, 2018 at 01:09:00PM +0800, Dave Young wrote:
> > It is not the content, I think it is a good catch from Boris, it would
> > be good to document the exported things in somewhere eg.
> > Documentation/kdump/vmcoreinfo.txt

For the vmcoreinfo variables document, I personally think it might be
not necessary. The reason is that all the old varialbles are exported
with the name of themselves. We know what they are or what they
represent since they are all kernel symbols or macro. Only this me_mask,
it's a local variable and store the value of sme_me_mask for now, may
store more info later like Petr mentioned, and also will store the memory
encryption information of TME (which is intel's transparent memory encryption).
We can add code comment around to tell these.

Personal opinion.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
