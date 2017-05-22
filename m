Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dCh9s-0006OT-FS
 for kexec@lists.infradead.org; Mon, 22 May 2017 06:49:38 +0000
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [PATCH] kexec/kdump: Minor Documentation updates for arm64 and
 Image
Date: Mon, 22 May 2017 06:49:13 +0000
Message-ID: <AM5PR0401MB25453F52820674F1D07EC8569AF80@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1495085600-2645-1-git-send-email-Bharat.Bhushan@nxp.com>
 <20170518055914.GC4059@dhcp-128-65.nay.redhat.com>
 <20170519034514.GA4283@fireball>
 <2ed84f9f-76c8-62eb-36b5-e97568ba3a2e@redhat.com>
In-Reply-To: <2ed84f9f-76c8-62eb-36b5-e97568ba3a2e@redhat.com>
Content-Language: en-US
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
To: Pratyush Anand <panand@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Pratyush Anand [mailto:panand@redhat.com]
> Sent: Monday, May 22, 2017 12:09 PM
> To: AKASHI Takahiro <takahiro.akashi@linaro.org>; Dave Young
> <dyoung@redhat.com>; Bharat Bhushan <bharat.bhushan@nxp.com>;
> bhe@redhat.com; vgoyal@redhat.com; corbet@lwn.net;
> kexec@lists.infradead.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] kexec/kdump: Minor Documentation updates for
> arm64 and Image
> 
> 
> 
> On Friday 19 May 2017 09:15 AM, AKASHI Takahiro wrote:
> >>> +to load dump-capture kernel.
> >>> +
> >>> +   kexec -p <dump-capture-kernel-Image> \
> >>> +   --initrd=<initrd-for-dump-capture-kernel> \
> >>> +   --append="root=<root-dev> <arch-specific-options>"
> >> For uncompressed Image, dtb is not necessary?
> > Just for clarification, dtb is optional for both vmlinux and Image on
> > arm64. (This means you can specify it if you want.) But this is also
> > true for initrd and append(command line) to some extent.
> 
> Yes, I agree.

Should I mention "-dtb" also for "Image"?

Also do we need to mention that it is optional somewhere in this document? I do not see "optional" is mentioned for other parameters and architecture.

Does this looks ok:

	" -dtb=<optional-dtb-for-dump-capture-kernel> \"

Thanks
-Bharat

> >
> > More precisely, whether these parameters are optional or not will
> > depend on architectures, not formats, I believe.
> 
> May be not architecture, rather a distro environment.
> 
> For example, we should be able to work without --initrd for any arch if kernel
> has been compiled by configuring CONFG_INITRAMFS_SOURCE.
> 
> ~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
