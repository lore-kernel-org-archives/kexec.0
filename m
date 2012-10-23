Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQjsc-0005aK-0G
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 19:11:10 +0000
Received: by mail-vc0-f177.google.com with SMTP id p16so4586933vcq.36
 for <kexec@lists.infradead.org>; Tue, 23 Oct 2012 12:11:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121023173941.GF16496@redhat.com>
References: <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com>
 <20121022204339.GG3401@redhat.com>
 <20121023020429.GA20493@verge.net.au>
 <20121023132413.GB16496@redhat.com>
 <87391517ev.fsf_-_@xmission.com>
 <20121023173941.GF16496@redhat.com>
Date: Tue, 23 Oct 2012 23:11:05 +0400
Message-ID: <CAJGZr0KeivwwqA84n6k-xLpXBY59ekWCsfQN7UfiGxVz7xm73Q@mail.gmail.com>
Subject: Re: [RFC] Kdump with signed images.
From: Maxim Uvarov <muvarov@gmail.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

2012/10/23 Vivek Goyal <vgoyal@redhat.com>:
> On Tue, Oct 23, 2012 at 09:26:32AM -0700, Eric W. Biederman wrote:
>
> [..]
>> > I think this will be a new parallel path and this new path should be taken
>> > only on kernel booted with secure boot enabled. (Either automatically or
>> > by using some kexec command line option). So nothing should be broken
>> > because we never supported anything on secure boot enabled system.
>>
>> Rubbish.  Kexec works just fine today on a secure boot enabled system.
>> Ignoring the nonsense that there is no such thing as a secure boot
>> enabled linux system.
>
> I think it is a security hole for the systems where we don't want to run
> unsigned priviliged code. So yes, it works as of today, but at some point
> of time we shall have to close this hole.
>
> Thanks
> Vivek
>
Signatures kernel & modules in general good for support reason. We can
say for example that we support only signed kernel and signed modules
for that kernel, so we are sure that this binaries match our source.
But what is the reason of checking signatures in kexec? If you have
root privileges then more likely you have access to boot loader or to
physical machine (console, bios). Might be useful only for embedded
things to prevent enthusiasts play with already manufactured devices.

Maxim.

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
