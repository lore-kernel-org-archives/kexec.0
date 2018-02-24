Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1epg1c-0003cy-US
 for kexec@lists.infradead.org; Sat, 24 Feb 2018 20:02:31 +0000
Date: Sat, 24 Feb 2018 21:02:10 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] kexec: do KEXEC_FILE_LOAD and fallback to KEXEC_LOAD if
 not supported.
Message-ID: <20180224210210.1d0f0613@naga.suse.cz>
In-Reply-To: <20180224014342.GA11298@dhcp-128-65.nay.redhat.com>
References: <20180222222442.9422-1-msuchanek@suse.de>
 <20180222232043.GC693@localhost.localdomain>
 <20180223092900.76a5dd33@ezekiel.suse.cz>
 <20180224014342.GA11298@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
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
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

Hello,

On Sat, 24 Feb 2018 10:19:09 +0800
Baoquan He <bhe@redhat.com> wrote:

> Hi Petr,
> 
> On 02/23/18 at 09:29am, Petr Tesarik wrote:
> > Hi Baoquan,
> > 
> > On Fri, 23 Feb 2018 07:20:43 +0800
> > Baoquan He <bhe@redhat.com> wrote:
> >   
> > > Hi Michal,
> > > 
> > > On 02/22/18 at 11:24pm, Michal Suchanek wrote:  
> > > > The new KEXEC_FILE_LOAD is preferred in the case the platform
> > > > supports it because it allows kexec in locked down secure boot
> > > > mode.
> > > > 
> > > > However, some platforms do not support it so fall back to the
> > > > old syscall there.    
> > > 
> > > I didn't read code change, just from patch log, I tend to not
> > > agree. There are two options KEXEC_FILE_LOAD and KEXEC_LOAD, some
> > > platforms do not support, why does some platforms not choose
> > > KEXEC_LOAD, the working one? Why bother to make change in code? I
> > > believe there's returned message telling if KEXEC_FILE_LOAD works
> > > or not.  
> > 
> > Well... let me give a bit of background. As you have probably
> > noticed, this syscall was originally available only for x86_64, but
> > more and more architectures are also adding it now.
> > 
> > Next, kexec is actually called by a script (which locates a suitable
> > kernel and initrd, constructs the kernel command line, etc.). The
> > script must either:
> > 
> >   A. know somehow if the currently running kernel implements
> >      kexec_file_load(2), or
> > 
> >   B. try one method first, and if it fails, retry with the other.
> > 
> > I agree that kexec(1) should probably allow the user to force a
> > specific method, but I don't see the benefit of implementing
> > fallback in an external script and not in kexec-tools itself.
> > 
> > OTOH if you want to push the fallback logic out of kexec-tools,
> > then I would like to get better diagnostic at least. Letting my
> > script parse kexec output is, um, suboptimal.  
> 
> Thanks for the details!
> 
> Firstly, this patch is very ugly. It mixs the falling back issue, doc
> adding, code cleanup in one patch. It's not easy to see how many lines
> of code change involved.

The -s option is special-cased and I needed to un-special-case it to be
able to use either syscall. I suppose this can be split.

> 
> Secondly, I personally like better the A or B two options. 
Which the patch does provide. If you want A you can select it. if you
want B you can select it as well. If you do not select either kexec
tries A and if not supported tries B. 
>  For A,
> checking ARCH in script might be a easier thing. 
What does checking ARCH in a script tell you? You need to check that
the syscall is supported both in kexec and the running kernel. And only
kexec can do that.
> And for B, just check
> if "syscall kexec_file_load not available" is printed, then retry the
> KEXEC_LOAD.

Oh right, that's totally robust programming. If kexec does not know how
to call KEXEC_FILE_LOAD then the message is printed to stderr and -1 is
returned whereas when kexec thinks it knows how to call KEXEC_FILE_LOAD
and the kernel does not support it nothing is printed and the
return code from kernel is passed through which is hopefully -ENOSYS.

Can we at least make the return code consistent?

> 
> And the falling back may give people a feeling that that ARCH support
> the file mode loading.

Why? How?

Previously they had to select KEXEC_FILE_LOAD with an undocumented
option. It is now documented and when used the fallback is disabled -
no change. 

> Besides, if fall back to KEXEC_LOAD when
> KEXEC_FILE_LOAD is tried but not supported this time, next time people
> may want to do fall back when KEXEC_FILE_LOAD is tried but failed,
> since there has been a precedent. This might be not good for keeping
> code logic simple, add complexity to maintaining.

What complexity are you talking about? That is exactly what the
fallback does except it checks that the error code was ENOSYS. It might
make sense to also use the fallback when the file format is not
recognized by the kernel. KEXEC_FILE_LOAD currently does not support
multiboot and uImage formats. So if a specific error code is returned
in this case (as opposed to known image type which is invalid) it might
make sense to use the fallback as well.

> 
> My personal opinion.
> 
> Thanks
> Baoquan
> 



On Sat, 24 Feb 2018 09:43:42 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 02/23/18 at 09:29am, Petr Tesarik wrote:
> > Hi Baoquan,
> > 
> > On Fri, 23 Feb 2018 07:20:43 +0800
> > Baoquan He <bhe@redhat.com> wrote:
> >   
> > > Hi Michal,
> > > 
> > > On 02/22/18 at 11:24pm, Michal Suchanek wrote:  
> > > > The new KEXEC_FILE_LOAD is preferred in the case the platform
> > > > supports it because it allows kexec in locked down secure boot
> > > > mode.
> > > > 
> > > > However, some platforms do not support it so fall back to the
> > > > old syscall there.    
> > > 
> > > I didn't read code change, just from patch log, I tend to not
> > > agree. There are two options KEXEC_FILE_LOAD and KEXEC_LOAD, some
> > > platforms do not support, why does some platforms not choose
> > > KEXEC_LOAD, the working one? Why bother to make change in code? I
> > > believe there's returned message telling if KEXEC_FILE_LOAD works
> > > or not.  
> > 
> > Well... let me give a bit of background. As you have probably
> > noticed, this syscall was originally available only for x86_64, but
> > more and more architectures are also adding it now.
> > 
> > Next, kexec is actually called by a script (which locates a suitable
> > kernel and initrd, constructs the kernel command line, etc.). The
> > script must either:
> > 
> >   A. know somehow if the currently running kernel implements
> >      kexec_file_load(2), or
> > 
> >   B. try one method first, and if it fails, retry with the other.
> > 
> > I agree that kexec(1) should probably allow the user to force a
> > specific method, but I don't see the benefit of implementing
> > fallback in an external script and not in kexec-tools itself.
> > 
> > OTOH if you want to push the fallback logic out of kexec-tools,
> > then I would like to get better diagnostic at least. Letting my
> > script parse kexec output is, um, suboptimal.  
> 
> In Fedora/RHEL we use this in scripts by checking the arch first,
> for distribution it is enough? 

No. That means you need to update the script when you implement
KEXEC_FILE_LOAD on a new arch. Worse, you need to check the kernel
version so it works on old kernel as well.

>  There are also some other arch
> dependent options in kexec-tools, there is no way to just use same
> for every different platform without checking in scripts. 

Like?

And here I mean options that are specific to the platform and not a
particular system. Because system-specific options have to be set case
by case, obviously. I see no kexec option that would generally apply on
one arch and not other except -s.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
