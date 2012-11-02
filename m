Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TUOuZ-0000HM-08
 for kexec@lists.infradead.org; Fri, 02 Nov 2012 21:36:19 +0000
Message-ID: <50943CCB.5080504@zytor.com>
Date: Fri, 02 Nov 2012 14:36:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody> <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody> <20121018193831.GD18147@redhat.com>
 <874nlrv2ni.fsf@xmission.com> <20121019020630.GA27052@redhat.com>
 <877gqnnnf0.fsf@xmission.com> <20121019175301.GG27052@redhat.com>
 <87bofu9pj9.fsf@xmission.com>
In-Reply-To: <87bofu9pj9.fsf@xmission.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Matthew Garrett <mjg@redhat.com>

On 10/22/2012 02:15 PM, Eric W. Biederman wrote:
>>
>> This is like re-designing the kexec/kdump and I really wish there is
>> an easier way to handle the case signed kernels.
> 
> Yes.  Which is why either a signed puragtory or a signed /sbin/kexec
> look very attractive.
> 

Signed purgatory sounds like The Right Thing.  Doing relocation in
purgatory should be quite trivial; I'd be happy to work with people if
they need pointers how to do it.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
