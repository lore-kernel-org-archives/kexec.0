Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UE16T-0001Pg-Rt
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 17:29:12 +0000
Message-ID: <513A1FE1.9040407@citrix.com>
Date: Fri, 8 Mar 2013 17:29:05 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
 <5139CE3C.8070801@citrix.com>
 <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
 <5139EF2F.2060107@citrix.com>
 <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Vrabel <david.vrabel@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

<snip>
>> The tools know what mode the image must be called it and it can tell the
>> hypervisor and the hypervisor can trivial setup the correct mode.
>>
>> I propose:
>>
>> * Tools say: "here's an image, call it in mode X".
>>
>> You suggest:
>>
>> * Hypervisor implicitly says through some unspecified side channel: "I
>> only call images in mode Y".
> Purgatory is clearly defined. Please look into kexec-tools/purgatory.
> It is integral part of kexec infrastructure.

Purgatory might be well defined, but that is not relevant here.

The kexec syscall and hypercall basically amount to "Here is a blob. 
Its architecture is $X and its entry point is $Y" (Give or take some
reconstruction)

Xen should not be making any assumptions about these things.

As it currently stands, Xen will assume that KEXEC_load from a pv_32on64
domain is an i386 image, while a KEXEC_load from a 64bit PV domain is an
x86_64 image.

The fact that this currently works in the common case of having the
crash kernel with the same architecture as the dom0 kernel is by luck
rather than good guidance.

Furthmore, the design of the interface should not be deliberately
crippled because the common user of it "can deal with it like this";
kexec-tools is not the only potential consumer of this interface.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
