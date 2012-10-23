Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQfwz-0007wI-11
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 14:59:27 +0000
Date: Tue, 23 Oct 2012 10:59:20 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121023145920.GD16496@redhat.com>
References: <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121023131854.GA16496@redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Oct 23, 2012 at 09:18:54AM -0400, Vivek Goyal wrote:

[..]
> > >> There are 3 options for trusting /sbin/kexec.  There are IMA and EMA,
> > >> and it is conceivable to have ELF note sections with signatures for
> > >> executables.
> > >
> > > Can you please tell more about what is EMA and IMA. I did quick google
> > > and could not find much.
> > 
> > That should have been EVM and IMA.  Look under security/integrity/.  I
> > don't know much about them but they appear to be security modules with a
> > focus on verifying checksum or perhaps encrypted hashes of executables
> > are consistent.
> 
> I will do some quick search there and I see if I can understand something.
> 

Ok, I quickly went through following paper.

http://mirror.transact.net.au/sourceforge/l/project/li/linux-ima/linux-ima/Integrity_overview.pdf

So it looks like that IMA can store the hashes of files and at execute
time ensure those hashes are unchanged to protect against the possibility
of modification of files.

But what about creation of a new program which can call kexec_load()
and execute an unsigned kernel. Doesn't look like that will be
prevented using IMA.

Whole idea behind UEFI secure boot seems to be that all signing happens
outside the running system and now only signed code can run with higher
priviliges. IMA seems to be only protecting against only making sure
existing binaries are not modifed but it does not seem to prevent against
installation of new binaries and these binaries take advantage of kexec
system call to load an unsigned kernel. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
