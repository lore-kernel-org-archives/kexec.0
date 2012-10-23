Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQhtM-0007HV-SI
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 17:03:50 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com> <87fw552mb4.fsf_-_@xmission.com>
 <20121023163125.GC32085@srcf.ucam.org>
Date: Tue, 23 Oct 2012 10:03:37 -0700
In-Reply-To: <20121023163125.GC32085@srcf.ucam.org> (Matthew Garrett's message
 of "Tue, 23 Oct 2012 17:31:25 +0100")
Message-ID: <874nllunme.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Kdump with signed images
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
To: Matthew Garrett <mjg@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

Matthew Garrett <mjg@redhat.com> writes:

> On Tue, Oct 23, 2012 at 09:19:27AM -0700, Eric W. Biederman wrote:
>> No.  UEFI secure boot has absolutely nothing todo with this.
>> 
>> UEFI secure boot is about not being able to hijack the code EFI runs
>> directly.  Full stop.
>
> No. It's about ensuring that no untrusted code can be run before any OS 
> kernel, which means that no untrusted code can run *in* any OS kernel.

Hogwash.

- All code has bugs.
- Firmware is particularly susceptible to buggy implementations.
- In the presence of bugs no guarantees can be made.
- All you can do is limit your level of exposure.
- Verifying a signature before you run code seems a reasonable way to
  limit exposure to code that can exploit bugs.

Anything else is policy people build on top of the mechanisms UEFI gives
them.



The statement that no untrusted code can run *in* any OS kernel is
ridiculous on the face of it.  In general all distros ship with patches
that have not received enough review to have been merged into the main
linux kernel.  Aka untrusted code.  Nothing has fixed the UEFI bugs aka
untrusted code.  Not to mention the how many little trust I have in
unreviewable binary blobs that UEFI needs to support to run OS's like
OSX and Windows.


Targeting never running any untrusted code in ring 0 seems like a
reasaonable target, and worth figuring out how to implement.  But don't
justify it by saying UEFI in secure boot mode requires it.  And don't
forget that what people trust are different things.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
