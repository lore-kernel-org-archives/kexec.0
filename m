Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnQ3u-00086f-N5
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 09:45:07 +0000
Date: Mon, 2 Dec 2013 10:44:41 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131202094441.GB7380@pd.tnic>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-8-git-send-email-dyoung@redhat.com>
 <20131127140732.GD32267@pd.tnic>
 <20131129091415.GH4186@dhcp-16-126.nay.redhat.com>
 <20131129164632.GD4266@pd.tnic>
 <20131202024914.GD3999@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131202024914.GD3999@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon, Dec 02, 2013 at 10:49:15AM +0800, Dave Young wrote:
> All these setup_data passing, remapping etc. is mostly for kexec,
> add a lot of contiditional #if #endif makes the code a mess. I would
> prefer to not do this if you are not strongly object.

Right, having efi_kexec.c could solve all that, see my other mail.

> I'm confused how to connect this with DMI..

This HP platform - like any other platform out there - has specific DMI
strings identifying it. Look for examples calling dmi_check_system().

> Ok, so I will leave this to you after this series settle down.

Ok,

/me puts it on the TODO list :)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
