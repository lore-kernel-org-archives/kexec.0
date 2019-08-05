Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hugUk-0001dB-Se
 for kexec@lists.infradead.org; Mon, 05 Aug 2019 17:10:04 +0000
Received: by mail-io1-xd44.google.com with SMTP id s7so168692782iob.11
 for <kexec@lists.infradead.org>; Mon, 05 Aug 2019 10:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 5 Aug 2019 10:09:43 -0700
Message-ID: <CACdnJusRUnhmOLdowqbGoM9Z-tWsKrhZ8sFfQUUmjyKmRVN+vw@mail.gmail.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
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
Cc: bhsharma@redhat.com, linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Mon, Aug 5, 2019 at 1:36 AM Dave Young <dyoung@redhat.com> wrote:
>
> kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> just reset while calling efi_delete_dummy_variable();  Unfortunately
> I don't know how to debug the firmware, it is also possible a potential
> problem on real hardware as well although nobody reproduced it.
>
> The intention of efi_delete_dummy_variable is to trigger garbage collection
> when entering virtual mode.  But SetVirtualAddressMap can only run once
> for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> a good place to clean dummy object.

I agree that this isn't necessarily the best place to do this in the
kexec case, but given we control the firmware, figuring out what's
actually breaking seems like a good plan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
