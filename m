Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBbEI-0003Uj-7u
 for kexec@lists.infradead.org; Wed, 03 Apr 2019 08:26:43 +0000
Date: Wed, 3 Apr 2019 16:26:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403082634.GA14852@dhcp-128-65.nay.redhat.com>
References: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
 <20190403073023.GF1555@localhost.localdomain>
 <20190403075015.GQ7627@MiWiFi-R3L-srv>
 <20190403082313.GA14838@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190403082313.GA14838@dhcp-128-65.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/03/19 at 04:23pm, Dave Young wrote:
> On 04/03/19 at 03:50pm, Baoquan He wrote:
> > On 04/03/19 at 03:30pm, Chao Fan wrote:
> > > On Wed, Apr 03, 2019 at 02:39:11PM +0800, Dave Young wrote:
> > > >> Actually I got some different kexec test results.
> > > >> 
> > > >> Yesterday, with my installed kernel (based on git head several weeks
> > > >> ago), kexec kernel panics.
> > > >> 
> > > >> Then I tried latest mainline with git pull, everything works, (with or
> > > >> without the patch, and can not reproduce the bug this patch is fixing)
> > > >> 
> > > >> Today, test again, kexec reboot hangs (with or without your patch), but
> > > >> kdump works always (with or without the patch)
> > > >> 
> > > >> It is weird to me. Probably I need find out why I can not reproduce the
> > > >> bug this patch is addressing first.
> > > >> 
> > > >> earlyprintk seems not working for me anymore, it is not easy to debug on
> > > >> laptop now.
> > > >> 
> > > >> But the patch itself is clear, I think it should be good.  There might be
> > > >> other things broken.
> > > >
> > > >Disable your immovable mem code then everything works for me.  There
> > > >might be something wrong in the code.  Also "nokaslr" does not help, it
> > > >should be another problem 
> > > 
> > > If "nokaslr" doesn't help, so I think
> > > >+      /*num_immovable_mem = count_immovable_mem_regions();*/
> > > also doesn't help. I think the problem is from get_rsdp_addr().
> > 
> > Yes, seems get_rsdp_addr() has issue in this case. I am wondering if we
> > can adjust the postion of get_rsdp_addr() calling. If nokaslr is
> > specified, no need to get rsdp?
> 
> I assumed the early code is only be useful for kaslr, if this is true
> then no need to get rsdp in case nokaslr.
> 
> But I vaguely remember Boris want the boot_params rsdp pointer be a
> general thing, I did not followed up these patch discussions, need to see how Boris thinks about this.
> 
Personally I would like to have a cmdline to bypass the early acpi code
because early code is hard to debug, if we have something weird happens
we can try to gate out these code, and then get some idea..

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
