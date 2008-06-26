Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBw9h-0008Sm-UO
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 18:25:14 +0000
Date: Thu, 26 Jun 2008 14:18:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
Message-ID: <20080626181841.GE3878@redhat.com>
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
	<18531.20387.111875.576837@harpo.it.uu.se>
	<20080626104524.2d7ed1ab@halley.suse.de>
	<18531.23894.572847.322265@harpo.it.uu.se>
	<4863D930.2040300@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4863D930.2040300@kernel.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com

On Thu, Jun 26, 2008 at 11:00:16AM -0700, H. Peter Anvin wrote:
> Mikael Pettersson wrote:
>> Bernhard Walle writes:
>>  > > It should be configurable. Whether it's done via CONFIG_KEXEC or its own
>>  > > option I don't care.
>>  >  > Ok, changed:
>>  >  > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>>  > index 1008737..73fcc59 100644
>>  > --- a/drivers/firmware/Kconfig
>>  > +++ b/drivers/firmware/Kconfig
>>  > @@ -28,7 +28,7 @@ config EDD_OFF
>>  >   >  config FIRMWARE_MEMMAP
>>  >      def_bool y
>>  > -    depends on X86_64 || X86_32
>>  > +    depends on (X86_64 || X86_32) && KEXEC
>>  >   >  config EFI_VARS
>>  >         tristate "EFI Variable Support via sysfs"
>>
>> Yep, thanks.
>>
>
> Making this depend on KEXEC would be most unfortunate.  This is valuable  
> information for finding all kinds of issues even in the absence of KEXEC.
>

Agreed.

> I really don't see a point in making this configurable, except perhaps  
> under CONFIG_EMBEDDED.

I think we should just not put this functionality under any CONFIG option.
If we put it under CONFIG_EMBEDDED,  then even for using kexec, one
shall have to turn CONFIG_EMBEDDED on which probably does not make much
sense.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
