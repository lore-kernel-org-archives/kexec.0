Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tgr3q-0001XG-Nz
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 06:05:24 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 7 Dec 2012 01:05:21 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3AD4DC9003C
 for <kexec@lists.infradead.org>; Fri,  7 Dec 2012 01:05:17 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB765Hrs30933224
 for <kexec@lists.infradead.org>; Fri, 7 Dec 2012 01:05:17 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB765Gpk018292
 for <kexec@lists.infradead.org>; Fri, 7 Dec 2012 01:05:16 -0500
Message-ID: <50C18718.40902@linux.vnet.ibm.com>
Date: Fri, 07 Dec 2012 11:35:12 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <1350981766.43974385.1354807618743.JavaMail.root@redhat.com>
In-Reply-To: <1350981766.43974385.1354807618743.JavaMail.root@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Vivek Goyal <vgoyal@redhat.com>, buendgen@de.ibm.com



On 2012-12-06 20:56, Dave Anderson wrote:

> 
> 
> ----- Original Message -----
> 
>>
>> Another approach is to dynamically load libeppic library - similar way
>> how crash does it. No major changes will be done to makedumpfile code,
>> except the addition of --eppic flag. Upon specifying --eppic flag
>> makedumpfile will dlopen libeppic.so, which will have functionality to
>> scrub the specified data. This will prevent makedumpfile bloat and will
>> not affect the size of initramfs as --eppic is only specified during
>> post processing. The distribution should build and ship libeppic.so and
>> the procedure for building .so will be similar to what we have in
>> crash.
> 
> OK, so based upon the most recent discussion here:
> 
>  Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
>  http://lists.infradead.org/pipermail/kexec/2012-December/007452.html
> 
> Aravinda states that he will be posting an update for makedumpfile 
> that will dlopen() a new "libeppic.so" shared object that is built
> with the libeppic.a library.
> 
> The upstream eppic git tree contains an "applications/crash" subdirectory
> that contains the code that creates a crash-utility-specific "eppic.so" file.
> 
> Accordingly, this new proposal will also require new source file(s) and
> a build process to create this new makedumpfile-specific "libeppic.so" 
> shared object.
>    
> Arvinda -- will you be proposing an additional "applications/makedumpfile"
> subdirectory for the upstream eppic git tree that can be used to create
> the makedumpfile-specific libeppic.so file?


This is what I am planning.

A new extension_eppic.c file will be created under makedumpfile source
directory. This file is equivalent to applications/crash/eppic.c in
upstream eppic repository. A new target will be added to the Makefile of
makedumpfile to build the shared library and to build this shared
library libeppic.a would be required. The makedumpfile specific shared
library will be named different - say eppic_mkdumpfile.so to avoid
conflict with crash specific libeppic.so.

The reason for including extension_eppic.c under makedumpfile source is
because it will be dependent on other functions in makedumpfile code
like dwarf related calls etc. People modifying those functions should be
aware of the callers in extension_eppic.c and if this is included in
upstream eppic code, it will be easily overlooked (or may not be aware
of its existence).

A flag --eppic will be added to makedumpfile which will dlopen the
shared library. Few additional helper functions will be added to
dwarf_info.c and erase_info.c - the same functions which are in v2 of
the patchset.


> 
> Dave
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
