Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hepfk-00035z-3t
	for kexec@lists.infradead.org; Fri, 20 Apr 2007 05:45:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] kexec cant load OpenBSD
References: <4627C7DA.7010401@esentire.com> <20070420065451.GA14852@in.ibm.com>
Date: Fri, 20 Apr 2007 03:43:48 -0600
In-Reply-To: <20070420065451.GA14852@in.ibm.com> (Vivek Goyal's message of
	"Fri, 20 Apr 2007 12:24:51 +0530")
Message-ID: <m1ejmfl6sr.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: fastboot@osdl.org, Jon Steel <jon.steel@esentire.com>, Kexec Mailing List <kexec@lists.infradead.org>

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Thu, Apr 19, 2007 at 03:49:46PM -0400, Jon Steel wrote:
>> Hi
>> 
>> Im running Gentoo and Im trying to use kexec to start up OpenBSD. I've
>> got it set up correct because I can do a boot into Gentoo. Here is what
>> happens:
>> 
>> base ~ # kexec -l /boot/bsd --type="elf-x86"
>> Base address: d0200120 is not page aligned
>> 
>
> Above address indicates that some loadable program segment is not
> page size(4K) aligned hence kexec is cribbing.
>
> A, "readelf -l /boot/bsd" should display the various program headers.
> I think you shall have to modify linker script of OpenBSD kernel to 
> generate page size aligned loadable segments.
>
> This does raise a question in my mind, why all the program headers
> should be loaded at page size boundaries? Just because ease of handling
> or there is some other reason too?
>
> Eric, you want to shed some light on this requirement?

A) The first problem is that we don't currently have support for OpenBSD
   and it does some weird things, and doesn't quite use the ELF fields
   generically.  So specific support will have to be written for at least
   part of it.

B) In the kernel side of the interface the page alignment restriction is
   important because of how our intermediate buffers work.  For user space
   ELF the page alignment of program segments is an important
   consideration to allow page sharing but for standalone executables we
   really shouldn't care and the restriction probably only exists 
   because we have a simple translation from ELF segment to the kernel
   segments.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
