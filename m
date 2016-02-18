Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x242.google.com ([2a00:1450:4010:c04::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aWVSw-0006Z4-9s
 for kexec@lists.infradead.org; Thu, 18 Feb 2016 20:46:23 +0000
Received: by mail-lb0-x242.google.com with SMTP id bc4so1829452lbc.0
 for <kexec@lists.infradead.org>; Thu, 18 Feb 2016 12:46:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160218204123.GA17042@codeblueprint.co.uk>
References: <1455723910-16710-1-git-send-email-matt@codeblueprint.co.uk>
 <1455723910-16710-2-git-send-email-matt@codeblueprint.co.uk>
 <1AE640813FDE7649BE1B193DEA596E883BB4D2A6@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0hAmCKc8Qn7sKQhdGhoAXH=zmXubx295K_Nbm9npOYzBw@mail.gmail.com>
 <20160218204123.GA17042@codeblueprint.co.uk>
Date: Thu, 18 Feb 2016 21:45:59 +0100
Message-ID: <CAJZ5v0gSNscOwpY9Edg4nLJWX8JMdo7v81vFrgzMLUkCMuFJ1Q@mail.gmail.com>
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
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Zheng, Lv" <lv.zheng@intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Feb 18, 2016 at 9:41 PM, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Thu, 18 Feb, at 09:15:28PM, Rafael J. Wysocki wrote:
>>
>> Actually, the reason is that, as a rule, the process for ACPICA
>> patches is that they first go to upstream ACPICA and they are acquired
>> by Linux from there.
>>
>> While there are some exceptions from that process, there also are good
>> reasons for that process to be followed, including the licensing one
>> mentioned by Lv.
>>
>> All that said, Matt, if you agree that the patch can be applied under
>> the BSD license, I think we can offer help with converting it to the
>> upstream ACPICA coding conventions and applying it there.  Lv, would
>> you be able to take care of that?
>
> I don't have any problem with that, but can we hold off on this patch
> for now? There's another approach to fixing the BGRT issue with kexec
> that's being discussed which would supersede this,
>
>   https://lkml.kernel.org/r/20160218141544.GH2651@codeblueprint.co.uk
>
> Assuming this patch does get picked up again, I'm happy to respin it
> against upstream ACPICA, but how do I go about getting dependent
> patches merged, PATCH 2/2 in this case?

We generate a Linux version of the patch out of the upstream ACPICA
sources (semi-automatically) and that can be merged into Linux in
advance.  We don't do that as a rule, but it can be done.  That at
least ensures that we'll be consistent with future ACPICA updates from
the upstream.

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
