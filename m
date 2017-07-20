Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dYEdd-0006yi-TM
 for kexec@lists.infradead.org; Thu, 20 Jul 2017 16:49:23 +0000
Subject: Re: [makedumpfile PATCH RFC v0.1] Implemented the
 --fill-excluded-pages=<value> feature
References: <mailman.5.1500490802.21882.kexec@lists.infradead.org>
 <120739175.36940762.1500564046445.JavaMail.zimbra@redhat.com>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <f171f3cd-5457-cc67-026e-e4af6df5b8be@oracle.com>
Date: Thu, 20 Jul 2017 05:48:53 -0700
MIME-Version: 1.0
In-Reply-To: <120739175.36940762.1500564046445.JavaMail.zimbra@redhat.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org



On 07/20/2017 08:20 AM, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
> 
>> When a page is excluded by any of the existing dump levels,
>> that page may still be written to the ELF dump file, depending
>> upon the PFN_EXCLUDED mechanism.
>>
>> The PFN_EXCLUDED mechanism looks for N consecutive "not
>> dumpable" pages, and if found, the current ELF segment is
>> closed out and a new ELF segment started, at the next dumpable
>> page. Otherwise, if the PFN_EXCLUDED criteria is not meet (that
>> is, there is a mix of dumpable and not dumpable pages, but not
>> N consecutive not dumpable pages) all pages are written to the
>> dump file.
>>
>> This patch implements a mechanism for those "not dumpable" pages
>> that are written to the ELF dump file to fill those pages with
>> constant data, rather than the original data. In other words,
>> the dump file still contains the page, but its data is wiped.
>>
>> The motivation for doing this is to protect real user data from
>> "leaking" through to a dump file when that data was asked to be
>> omitted. This is especially important for effort I currently am
>> working on to allow further refinement of what is allowed to be
>> dumped, all in an effort to protect user (customer) data.
>>
>> The patch is simple enough, however, it causes problems with
>> crash; crash is unable to load the resulting ELF dump file.
>> For example, I do the following as a test scenario for this
>> change:
>>
>> - Obtain a non-filtered dump file (eg. dump level 0, no -d option,
>>    or straight copy of /proc/vmcore)
>> - Run vmcore through 'crash' to ensure loads ok, test with
>>    commands like: ps, files, etc.
>>    % crash vmlinux vmcore
>> - Apply this patch and rebuild makedumpfile
>> - Run vmcore through makedumpfile *without* --fill-excluded-pages
>>    and with filtering to ensure no uintended side effects of patch:
>>    % ./makedumpfile -E -d31 -x vmlinux vmcore newvmcore
>> - Run new vmcore through crash to ensure still loads ok, test
>>    with commands like: ps, files, etc.
>>    % crash vmlinux newvmcore
>> - Run vmcore through makedumpfile *with* --fill-excluded-pages
>>    and with filtering to check side effects of patch:
>>    % ./makedumpfile -E -d31 --fill-excluded-pages=0 -x vmlinux vmcore
>>    newvmcore2
>> - Run new vmcore through crash to ensure still loads ok, test
>>    with commands like: ps, files, etc.
>>    % crash vmlinux newvmcore2
>>
>> But crash yields errors like:
>>    [...]
>>    This GDB was configured as "x86_64-unknown-linux-gnu"...
>>
>>    crash: cannot determine thread return address
>>    please wait... (gathering kmem slab cache data)
>>    crash: invalid kernel virtual address: 1c  type: "kmem_cache
>>    objsize/object_size"
>>
>> If the patch is correct/accurate, then that may mean that crash
>> is using data which it should not be.
> 
> Why would the crash utility be "using data which it should not be"
> if your patch is applied?
> 
> The two error messages above come from attempting to read memory
> from the kernel text region (the "thread return" message), and then
> the kmem_cache.object_size field of the kernel's kmem_cache data structure
> pointed to by its "kmem_cache" pointer.  It looks like the patch is
> causing bogus data to be returned for a given physical address >
> Dave
> 

Indeed, the patch was incorrect and was causing bogus data to be 
returned. I've corrected the patch and will re-post soon.

Eric
> 
>>
>> The more likely scenario is that the patch is not correct/accurate,
>> and I'm corrupting the dump file.
>>
>> Please provide feedback!!
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
