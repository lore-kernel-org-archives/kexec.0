Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsqNF-00FQPo-2P
 for kexec@lists.infradead.org; Mon, 14 Jun 2021 17:27:46 +0000
Date: Mon, 14 Jun 2021 20:27:36 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
Message-ID: <YMeRiDMet2JyOV4P@smile.fi.intel.com>
References: <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
 <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com>
 <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-efi <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Ard Biesheuvel <ardb@kernel.org>

On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 14, 2021 at 06:38:30PM +0300, Andy Shevchenko wrote:
> > On Sat, Jun 12, 2021 at 12:40:57PM +0800, Dave Young wrote:
> > > > Probably it is doable to have kexec on 32bit efi working
> > > > without runtime service support, that means no need the trick of fixed
> > > > mapping.
> > > > 
> > > > If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
> > > > patches for test.
> > > 
> > > Unfortunately I failed to setup a 32bit efi guest,  here are some
> > > untested draft patches, please have a try.
> > 
> > Thanks for the patches.
> > 
> > As previously, I have reverted my hacks and applied your patches (also I
> > dropped patches from previous mail against kernel and kexec-tools) for both
> > kernel and user space on first and second environments.
> > 
> > It does NOT solve the issue.
> > 
> > If there is no idea pops up soon, I'm going to resend my series that
> > workarounds the issue.
> 
> Hold on, I may have made a mistake during testing. Let me retest this.

Double checked, confirmed that it's NOT working.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
