Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TR4tG-000147-Hd
 for kexec@lists.infradead.org; Wed, 24 Oct 2012 17:37:16 +0000
Date: Wed, 24 Oct 2012 13:36:51 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121024173651.GE1821@redhat.com>
References: <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fw552mb4.fsf_-_@xmission.com>
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
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Oct 23, 2012 at 09:19:27AM -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Tue, Oct 23, 2012 at 09:18:54AM -0400, Vivek Goyal wrote:
> >
> > [..]
> >> > >> There are 3 options for trusting /sbin/kexec.  There are IMA and EMA,
> >> > >> and it is conceivable to have ELF note sections with signatures for
> >> > >> executables.
> >> > >
> >> > > Can you please tell more about what is EMA and IMA. I did quick google
> >> > > and could not find much.
> >> > 
> >> > That should have been EVM and IMA.  Look under security/integrity/.  I
> >> > don't know much about them but they appear to be security modules with a
> >> > focus on verifying checksum or perhaps encrypted hashes of executables
> >> > are consistent.
> >> 
> >> I will do some quick search there and I see if I can understand something.
> >> 
> >
> > Ok, I quickly went through following paper.
> >
> > http://mirror.transact.net.au/sourceforge/l/project/li/linux-ima/linux-ima/Integrity_overview.pdf
> >
> > So it looks like that IMA can store the hashes of files and at execute
> > time ensure those hashes are unchanged to protect against the possibility
> > of modification of files.
> >
> > But what about creation of a new program which can call kexec_load()
> > and execute an unsigned kernel. Doesn't look like that will be
> > prevented using IMA.
> >
> > Whole idea behind UEFI secure boot seems to be that all signing happens
> > outside the running system and now only signed code can run with higher
> > priviliges.
> 
> No.  UEFI secure boot has absolutely nothing todo with this.
> 
> UEFI secure boot is about not being able to hijack the code EFI runs
> directly.  Full stop.
> 
> Some people would like to implment a security policy that says
> you can't boot an untrusted version of windows from linux if you have
> booted with UEFI secure boot, so they don't get their bootloader
> signatures revoked by microsoft.
> 
> A security model relying on Microsoft's key is totally uniteresting to
> me.  Either signing at the UEFI level is of no use or Microsofts key
> will fall again to the combined assult of every cracker and every
> governmental dirty cyber ops division attacking it.  Not to mention that
> Microsoft has little incentive to keep linux booting.
> 
> I think it is reasonable to be able to support a policy where we can't
> boot unsigned versions of Microsoft windows.  However beyond being able
> to exclude booting windows being one criteria for our policy mechanism
> please don't even start to justify things with that ridiculous security
> policy even indirectly.
> 
> > IMA seems to be only protecting against only making sure
> > existing binaries are not modifed but it does not seem to prevent against
> > installation of new binaries and these binaries take advantage of kexec
> > system call to load an unsigned kernel. 
> 
> I believe you can combine IMA with EVM signed security attributes where
> the EVM signing key is offline, and the verification key is in the
> kernel.
> 
> The combination of IMA and EVM gets very close to being able to sign
> executables offline and be able to update them.

[ Again CCing lkml and IMA/EVM folks ]

After little reading, my understanding is EVM also does not support
offline signing. 

http://sourceforge.net/apps/mediawiki/linux-ima/index.php?title=Main_Page

Given the fact EVM protects IMA data (security.ima), which is generated
inline, I am not sure how EVM can sign images offline.

I might have misunderstood things, please correct me if that's not the
case.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
