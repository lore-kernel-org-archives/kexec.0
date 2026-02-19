Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E714AE9A053
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kccVFgKV/Gov4dZzwLE1ZqBthUx7ayVQs5AokW/GCIk=; b=I/Ru1/CnkfePVRimTHAZoCmojH
	nGTiXi5Rv5SqyMYCk0O4gJpzKdK2z1qeN4mVOqj8vS0E3W/0nuTa3sjgxKbynvt9ZqZ6mnb3d87dp
	J8kUcwG47grDYjGuxbVbzUp/D24SfAhGEltZ8MH+zGEd6tuVwQ6V3DN+veu8d/f7rYPrfG9+NPcNq
	EUjIQZzUYzyWGSnKXT63BWS+CND6cdHcFm9JbqLX5qZURRotBmYu8ADzsYiPottoEE1i+NAZo1u8u
	xrRI3N3BTU1SWG+Kmi9FZZGZw5VuOFcYmOjvhdSuiZAkyvM5ScEKSROE0XLFtqNHWFWFRuc6QPLDA
	5vHqiHPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7YO-0000000BgKQ-3rp8;
	Thu, 19 Feb 2026 17:11:04 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt7YL-0000000BgJw-3xX5
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 17:11:03 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61JHA6mF061543
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 19 Feb 2026 09:10:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61JHA6mF061543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771521011;
	bh=kccVFgKV/Gov4dZzwLE1ZqBthUx7ayVQs5AokW/GCIk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qi9a6aXIYjVNA1t7lLg6lec45w4xiw/YNvwOXsl/BeUiwX3xR8D9fg6pp9oKGexCZ
	 6D3eyWIxQARRqjXrLiPOKFSwMuvLa3SxUpYrik5QBcJlaohTjifVD4ietFKfvE7YN0
	 wGeIqxEW8FdjCO8akb1R+UoMvl4JtQ7/RU8Xif3Ylgo+7pe4T+aNWgPHm1TKvr0DBT
	 h5QK/ukeiKE88Z1agf+xXaZbQMsQlIdbiodoT0w2TISCu7dIboN8odsnzmqr+SnZuM
	 duXP5P8r7zdUdBl8CEBY5fTSLz/lMWYG/QiQKEhgKr0CyRp8VCM0Z1hAXRxr36F9Jq
	 mAhHSoO2EMSOA==
Date: Thu, 19 Feb 2026 09:10:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Simo Sorce <simo@redhat.com>
CC: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        nivedita@alum.mit.edu, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
User-Agent: K-9 Mail for Android
In-Reply-To: <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com> <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com> <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com> <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com> <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com> <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com> <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
Message-ID: <4AF70D88-AD0C-4421-B8D5-2055D6B5E736@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_091101_993921_55FDD3B6 
X-CRM114-Status: GOOD (  31.83  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On February 18, 2026 11:54:55 PM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wr=
ote:
>On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
>> On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat=2Ecom> =
wrote:
>>>
>>> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
>>> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=
=2Ecom> wrote:
>>> > >
>>> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacap=
ital=2Enet> wrote:
>>> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel=2Eorg> wrote:
>>> > > > >
>>> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P=2E Smith wrote:
>>> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
>>> > > > > =2E=2E=2E
>>> > > > > But would it be better to disable the runtime services by defa=
ult when doing a secure launch? PREEMPT_RT already does the same=2E
>>> > > >
>>> > > > So I have a possible way to disable EFI runtime service without =
losing
>>> > > > the ability to write EFI vars=2E  We come up with a simple file =
format
>>> > > > to store deferred EFI var updates and we come up with a place to=
 put
>>> > > > it so that we find it early-ish in boot the next time around=2E =
 (This
>>> > > > could be done via integration with systemd-boot or shim some oth=
er
>>> > > > boot loader or it could actually be part of the kernel=2E)  And =
then,
>>> > > > instead of writing variables directly, we write them to the defe=
rred
>>> > > > list and then update them on reboot (before TXT launch, etc)=2E =
 [0]
>>> > > > This would be a distincly nontrivial project and would not work =
for
>>> > > > all configurations=2E
>>> > > >
>>> > > > As a maybe less painful option, we could disable EFI runtime ser=
vices
>>> > > > but have a root-writable thing in sysfs that (a) turns them back=
 on
>>> > > > but (b) first extends a PCR to say that they're turned back on=
=2E
>>> > > >
>>> > > > (Or someone could try running runtime services at CPL3=2E=2E=2E)
>>> > > >
>>> > > > [0] I have thought for years that Intel and AMD should do this o=
n
>>> > > > their end, too=2E  Keep the sensitive part of SMI flash entirely=
 locked
>>> > > > after boot and, instead of using magic SMM stuff to validate tha=
t
>>> > > > write attempts have the appropriate permissions and signatures, =
queue
>>> > > > them up as deferred upates and validate the signatures on the ne=
xt
>>> > > > boot before locking flash=2E
>>> > > >
>>> > >
>>> > > *If* a physical EFI partition exists there is a lot to be said for=
 this approach=2E
>>> > >
>>> > > The only issue with this that I can see is for things like network=
 or CD/DVD booting where there isn't necessarily any EFI boot partition, it=
 might not be writable, or it might not be persistent (e=2Eg=2E http bootin=
g typically uses a ramdisk, like the old Linux initrd=2E)
>>> >
>>> > Hmm, I guess my approach is a 100% complete nonstarter for installin=
g
>>> > Linux from a CD, and it's really not awesome for installing Linux fr=
om
>>> > a USB stick=2E
>>>
>>> Doing any of this on a removable device feels generally like a trap=2E
>>> You get your USB disk in, try to boot, and it saves vars, but reboot
>>> fails for whatever reason, you plug it in another machine =2E=2E=2E an=
d it
>>> tries to "continue" from there? The amount of validation needed and
>>> testing for failure modes across reboots sounds really painful=2E
>>
>> I kind of stand by my other previous suggestion, though:
>>
>> As a maybe less painful option, we could disable EFI runtime services
>> but have a root-writable thing in sysfs that (a) turns them back on
>> but (b) first extends a PCR to say that they're turned back on=2E
>>
>
>After setting the EFI boot path to GRUB (or systemd-boot or whatever) at =
installation time, what other meaningful interactions do we expect with the=
 EFI runtime services?
>
>And given that the secure launch is orchestrated by the bootloader , with=
 which the kernel has a backchannel via its configuration file, it should b=
e rather straight-forward to implement the staging of variable updates ther=
e if we really need it=2E=20
>
>Doing any of this at the EFI/spec level might lead to a situation where t=
he OS now has to guess which of the provided APIs to manipulate variables i=
s the least broken=2E
>
>Of course, for readinf variables, dumping the RT variables into a memory =
buffer at boot time and exposing it via a EFI config table would be rather =
straight-forward, but it is also something I feel should be the job of the =
boot component that takes part in the decision to shield the runtime servic=
es from the OS=2E
>
>
>
>

The statement "that the kernel has a backchannel to" is *not true in gener=
al*=2E

