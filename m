Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5w2z-00046Q-R9
 for kexec@lists.infradead.org; Fri, 19 Jun 2015 13:09:30 +0000
Date: Fri, 19 Jun 2015 09:09:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150619130905.GA13714@redhat.com>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
 <87zj3zigug.fsf@x220.int.ebiederm.org>
 <20150616202757.GB14943@redhat.com>
 <87y4jjglvu.fsf@x220.int.ebiederm.org>
 <20150617014737.GB30214@redhat.com>
 <20150619070431.GI4636@dhcp-128-32.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150619070431.GI4636@dhcp-128-32.nay.redhat.com>
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Theodore Ts'o <tytso@mit.edu>, Petr Tesarik <ptesarik@suse.cz>, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Jun 19, 2015 at 03:04:31PM +0800, Dave Young wrote:
> On 06/16/15 at 09:47pm, Vivek Goyal wrote:
> > On Tue, Jun 16, 2015 at 08:32:37PM -0500, Eric W. Biederman wrote:
> > > Vivek Goyal <vgoyal@redhat.com> writes:
> > > 
> > > > On Tue, Jun 16, 2015 at 02:38:31PM -0500, Eric W. Biederman wrote:
> > > >> 
> > > >> Adding Vivek as he is the one who implemented kexec_file_load.
> > > >> I was hoping he would respond to this thread, and it looks like he
> > > >> simply has not ever been Cc'd.
> > > >> 
> > > >> Theodore Ts'o <tytso@mit.edu> writes:
> > > >> 
> > > >> > On Mon, Jun 15, 2015 at 09:37:05AM -0400, Josh Boyer wrote:
> > > >> >> The bits that actually read Secure Boot state out of the UEFI
> > > >> >> variables, and apply protections to the machine to avoid compromise
> > > >> >> under the SB threat model.  Things like disabling the old kexec...
> > > >> >
> > > >> > I don't have any real interest in using Secure Boot, but I *am*
> > > >> > interested in using CONFIG_KEXEC_VERIFY_SIG[1].  So perhaps we need to
> > > >> > have something similar to what we have with signed modules in terms of
> > > >> > CONFIG_MODULE_SIG_FORCE and module/sig_enforce, but for
> > > >> > KEXEC_VERIFY_SIG.  This would mean creating a separate flag
> > > >> > independent of the one Linus suggested for Secure Boot, but since we
> > > >> > have one for signed modules, we do have precedent for this sort of
> > > >> > thing.
> > > >> 
> > > >> My overall request with respect to kexec has been that we implement
> > > >> things that make sense outside of the bizarre threat model of the Linux
> > > >> folks who were talking about secure boot.
> > > >> 
> > > >> nI have not navigated the labyrinth of config options but having a way to
> > > >> only boot signed things with kexec seems a completely sensible way to
> > > >> operate in the context of signed images.
> > > >> 
> > > >> I don't know how much that will help given that actors with sufficient
> > > >> resources have demonstrated the ability to steal private keys, but
> > > >> assuming binary signing is an effective technique (or why else do it)
> > > >> then having an option to limit kexec to only loading signed images seems
> > > >> sensible.
> > > >
> > > > I went through the mail chain on web and here are my thoughts.
> > > >
> > > > - So yes, upstream does not have the logic which automatically disables
> > > >   the old syscall (kexec_load()) on secureboot systems. Distributions
> > > >   carry those patches.
> > > >
> > > > - This KEXEC_VERIFY_SIG option only cotrols the behavior for
> > > >   kexec_file_load() syscall and is not meant to directly affect any
> > > >   behavior of old syscall (kexec_load()). I think I should have named
> > > >   it KEXEC_FILE_VERIFY_SIG. Though help text makes it clear.
> > > >   "Verify kernel signature during kexec_file_load() syscall".
> > > >
> > > > - I think disabling old system call if KEXEC_VERIFY_SIG() is set
> > > >   will break existing setup which use old system call by default, except
> > > >   the case of secureboot system. And old syscall path is well tested
> > > >   and new syscall might not be in a position to support all the corner
> > > >   cases, atleast as of now.
> > > >
> > > > Ted, 
> > > >
> > > > So looks like you are looking for a system/option where you just want to
> > > > always make use of kexec_file_load() and disable kexec_load(). This sounds
> > > > like you want a kernel where kexec_load() is compiled out and you want
> > > > only kexec_file_load() in.
> > > >
> > > > Right now one can't do that becase kexec_file_load() depends on
> > > > CONFIG_KEXEC option.
> > > >
> > > > I am wondering that how about making CONFIG_KEXEC_FILE_LOAD independent
> > > > of CONFIG_KEXEC. That way one can set CONFIG_KEXEC_VERIFY_SIG=y, and
> > > > only signed kernel can be kexeced on that system.
> > > >
> > > > This should gel well with long term strategy of deprecating kexec_load()
> > > > at some point of time when kexec_file_load() is ready to completely
> > > > replace it.
> > > 
> > > Interesting.
> > > 
> > > I suspect that what we want is to have CONFIG_KEXEC for the core
> > > and additional CONFIG_KEXEC_LOAD option that covers that kexec_load call.
> > > 
> > > That should make it trivially easy to disable the kexec_load system call
> > > in cases where people care.
> > 
> > Or, we could create another option CONFIG_KEXEC_CORE/CONFIG_KEXEC_COMMON
> > which will be automatically selected when either CONFIG_KEXEC or
> > CONIG_KEXEC_FILE are selected.
> > 
> > All common code can go under this option and rest can go under respective
> > config options.
> > 
> > That way, those who have CONFIG_KEXEC=y in old config files will not be
> > broken. They don't have to learn about new options at all.
> 
> Vivek, It is slight better for reusing old config file, but CONFIG_KEXEC_LOAD
> sounds better. Do we have to maintain the compability for kconfig?
> 
> KEXEC_COMMON/KEXEC/KEXEC_FILE_LOAD is a little confusing. CONFIG_KEXEC
> should be the common kexec stuff naturally, it is strange to use CONFIG_KEXEC
> for only kexec_load syscall.

Hi Dave,

I think as a user I would like my old config file to work with new kernel.
It is a good idea to keep old config options until and unless we have a
very good reason.

To me following should be reasonable.

CONFIG_KEXEC --> Enable old syscall
CONFIG_FILE_KEXEC --> Enable new syscall

In fact we might not have to introduce CONFIG_KEXEC_COMMON. We can
just use

#ifdef (CONFIG_KEXEC) | ifdef (CONFIG_FILE_KEXEC
  /* Common code between two syscalls */
#endif

That way we don't introduce any new config options and stick to existing
ones. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
