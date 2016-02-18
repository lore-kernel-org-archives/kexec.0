Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x244.google.com ([2a00:1450:4010:c04::244])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aWUzO-0000ia-M0
 for kexec@lists.infradead.org; Thu, 18 Feb 2016 20:15:51 +0000
Received: by mail-lb0-x244.google.com with SMTP id h2so1511392lbs.2
 for <kexec@lists.infradead.org>; Thu, 18 Feb 2016 12:15:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB4D2A6@SHSMSX101.ccr.corp.intel.com>
References: <1455723910-16710-1-git-send-email-matt@codeblueprint.co.uk>
 <1455723910-16710-2-git-send-email-matt@codeblueprint.co.uk>
 <1AE640813FDE7649BE1B193DEA596E883BB4D2A6@SHSMSX101.ccr.corp.intel.com>
Date: Thu, 18 Feb 2016 21:15:28 +0100
Message-ID: <CAJZ5v0hAmCKc8Qn7sKQhdGhoAXH=zmXubx295K_Nbm9npOYzBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPICA: Tables: Add function to remove ACPI tables
From: "Rafael J. Wysocki" <rafael@kernel.org>
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
To: "Zheng, Lv" <lv.zheng@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Feb 18, 2016 at 3:34 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Matt Fleming
> [Lv Zheng]
> First, is it possible for you to submit an ACPICA patch instead of a Linux patch.
> The reasoning for doing this can be found at:
> https://acpica.org/Licensing

Actually, the reason is that, as a rule, the process for ACPICA
patches is that they first go to upstream ACPICA and they are acquired
by Linux from there.

While there are some exceptions from that process, there also are good
reasons for that process to be followed, including the licensing one
mentioned by Lv.

All that said, Matt, if you agree that the patch can be applied under
the BSD license, I think we can offer help with converting it to the
upstream ACPICA coding conventions and applying it there.  Lv, would
you be able to take care of that?

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
