Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqHah-00027o-8A
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 12:09:13 +0000
Date: Mon, 26 Feb 2018 13:08:58 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] kexec: do KEXEC_FILE_LOAD and fallback to KEXEC_LOAD if
 not supported.
Message-ID: <20180226130858.6c0a8d09@naga.suse.cz>
In-Reply-To: <20180226014515.GA2862@dhcp-128-65.nay.redhat.com>
References: <20180222222442.9422-1-msuchanek@suse.de>
 <20180222232043.GC693@localhost.localdomain>
 <20180223092900.76a5dd33@ezekiel.suse.cz>
 <20180224014342.GA11298@dhcp-128-65.nay.redhat.com>
 <20180224173431.12ab826c@ezekiel.suse.cz>
 <20180226014515.GA2862@dhcp-128-65.nay.redhat.com>
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

On Mon, 26 Feb 2018 09:45:15 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 02/24/18 at 05:34pm, Petr Tesarik wrote:
> > On Sat, 24 Feb 2018 09:43:42 +0800
> > Dave Young <dyoung@redhat.com> wrote:
> >   
> > > On 02/23/18 at 09:29am, Petr Tesarik wrote:  
> > > > Hi Baoquan,
> > > > 
> > > > On Fri, 23 Feb 2018 07:20:43 +0800
> > > > Baoquan He <bhe@redhat.com> wrote:
> > > >     
> > > > > Hi Michal,
> > > > > 
> > > > > On 02/22/18 at 11:24pm, Michal Suchanek wrote:    
> > > > > > The new KEXEC_FILE_LOAD is preferred in the case the
> > > > > > platform supports it because it allows kexec in locked down
> > > > > > secure boot mode.
> > > > > > 
> > > > > > However, some platforms do not support it so fall back to
> > > > > > the old syscall there.      
> > > > > 
> > > > > I didn't read code change, just from patch log, I tend to not
> > > > > agree. There are two options KEXEC_FILE_LOAD and KEXEC_LOAD,
> > > > > some platforms do not support, why does some platforms not
> > > > > choose KEXEC_LOAD, the working one? Why bother to make change
> > > > > in code? I believe there's returned message telling if
> > > > > KEXEC_FILE_LOAD works or not.    
> > > > 
> > > > Well... let me give a bit of background. As you have probably
> > > > noticed, this syscall was originally available only for x86_64,
> > > > but more and more architectures are also adding it now.
> > > > 
> > > > Next, kexec is actually called by a script (which locates a
> > > > suitable kernel and initrd, constructs the kernel command line,
> > > > etc.). The script must either:
> > > > 
> > > >   A. know somehow if the currently running kernel implements
> > > >      kexec_file_load(2), or
> > > > 
> > > >   B. try one method first, and if it fails, retry with the
> > > > other.
> > > > 
> > > > I agree that kexec(1) should probably allow the user to force a
> > > > specific method, but I don't see the benefit of implementing
> > > > fallback in an external script and not in kexec-tools itself.
> > > > 
> > > > OTOH if you want to push the fallback logic out of kexec-tools,
> > > > then I would like to get better diagnostic at least. Letting my
> > > > script parse kexec output is, um, suboptimal.    
> > > 
> > > In Fedora/RHEL we use this in scripts by checking the arch first,
> > > for distribution it is enough?  
> > 
> > No.
> > 
> > First, you would also have to check the kernel version (and
> > maintain an ugly mapping of which kernel version introduced
> > kexec_file_load on which architecture).  
> 
> The kernel version update is rare for these new syscall added, but
> it is indeed needed to match with them
> 
> > 
> > Second, it's not just the architecture. kexec_load(2) will fail if
> > SecureBoot is active. OTOH kexec_file_load(2) will fail if the
> > kernel is not signed. For kernel hackers who don't use SecureBoot,
> > signing self-built kernels is just overkill. So, you should also
> > check the state of SecureBoot, possibly also whether the kernel
> > image is signed with a valid key, repeating a bit too much of the
> > kernel logic, and quite likely introducing subtle differences...  
> 
> Hmm, I did not say the exact details, yes, we checked the Secure Boot
> state and only use kexec_file_load for that special case.
> 
> kexec_file and kexec_file_load is not exactly same so if one want to
> use one instead of another for a specific functionality it seems not
> good to automatically switch to another if one failed. For example
> which one should be the first choice, it is hard to say.

Hard to say indeed, However, I would assume that architectures that
implement kexec_file_load do so because it is required in some case and
hence it will be actively maintained when available. However, some
architectures may not require it and will be slow to implement it. So
using kexec_file_load when available sounds like the right thing.
Technically the implementation details are different but for most users
this does not matter.

For those that do care I provide option to select one or the other.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
