Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QmNyz-0001Gs-PK
	for kexec@lists.infradead.org; Thu, 28 Jul 2011 10:38:27 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6SAW854003250
	for <kexec@lists.infradead.org>; Thu, 28 Jul 2011 20:32:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6SAbbI5848126
	for <kexec@lists.infradead.org>; Thu, 28 Jul 2011 20:37:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6SAcJvx006431
	for <kexec@lists.infradead.org>; Thu, 28 Jul 2011 20:38:19 +1000
Message-ID: <4E313C17.7050609@linux.vnet.ibm.com>
Date: Thu, 28 Jul 2011 16:08:15 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading module
	debuginfo.
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
	<4E2FABA8.5000401@linux.vnet.ibm.com>
	<20110728181146.d91ee265.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110728181146.d91ee265.oomichi@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Keni'chi,

On 07/28/2011 02:41 PM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> This feature's patches are very large, and I created a devel branch
> on sourceforge git tree for sharing the code with you.
> 
> http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/filter-out-devel
> 
> I commited all of your patches and my cleanup patches.
> If you notice some problems or cleate some patches, please let me know them.
> 

Sure. Will take a look.

> On Wed, 27 Jul 2011 11:39:44 +0530
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>>>> + *
>>>> + * This function uses dwfl API's to apply relocation before reading the
>>>> + * dwarf information from module debuginfo.
>>>> + * On success, this function sets the dwarf_info.elfd and dwarf_info.dwarfd
>>>> + * after applying relocation to module debuginfo.
>>>> + */
>>>> +static int
>>>> +init_dwarf_info(void)
>>>
>>> Is the searching method of debuginfo file only for kernel module ?
>>> Or also for vmlinux ?
>>
>> Yes, the searching method is only for module debuginfo. For vmlinux we
>> set the dwarf_info.name_debuginfo before call to init_dwarf_info() and
>> we never call search routine dwfl_linux_kernel_report_offline() for
>> vmlinux. The routine dwfl_report_offline() applies the relocation on
>> specified debuginfo module. In case vmlinux it basically does nothing.
>>
>>> I feel this function is a little complex, and I'd like to make it simple.
>>> If only for kernel module, we can do it by separating the searching method
>>> from this function and calling it in case of kernel module.
>>
>> The init_dwarf_info() function gets called everytime when
>> get_debug_info() is called. The get_debug_info() is called multiple
>> times for same debuginfo file. This function tries to avoid the repeated
>> search for same debuginfo, hence the function is little complex.
>> 	- In case of kernel module the very first invocation of
>> init_dwarf_info() would call dwfl_linux_kernel_report_offline() which
>> will iterate over the available kernel modules and process the debuginfo
>> only for the module for which we are interested in.
>> 	- We set the dwarf_info.name_debuginfo with the debuginfo file name
>> found during the first invocation.
>> 	- The second invocation of init_dwarf_info() for same kernel module,
>> will find dwarf_info.name_debuginfo is already set and will avoid the
>> debuginfo search. In this case it will just apply relocation using
>> routine dwfl_report_offline().
>>
>> This function does not have any special handling code for vmlinux. The
>> function is independent of whether it is called for vmlinux or kernel
>> module. In case of vmlinux this function has absolutely no side effects.
> 
> If adding the searching method to the blow position and removing the code
> from init_dwarf_info(), I guess it makes the code simple.
> 
> @ process_config_file()
>  9402                         if (!set_dwarf_debuginfo(config->module_name,
>  9403                                                                 NULL, -1)) {
>  9404                                 ERRMSG("Skipping to next Module section\n");
>  9405                                 skip_section = 1;
>  9406                                 free_config(config);
>  9407                                 continue;
>  9408                         }
>  9409                         << HERE >> 

This may not be the correct place to call search method. We may end up
calling search method multiple times for same kernel module. I think
moving the search method inside set_dwarf_debuginfo() routine at below
position is a better place:

@set_dwarf_debuginfo()
	......
	......
	if (!strcmp(dwarf_info.module_name, "vmlinux") ||
                !strcmp(dwarf_info.module_name, "xen-syms"))
                return TRUE;
+	 << HERE >>
-        /* check to see whether module debuginfo is available */
-        if (!init_dwarf_info())
-                return FALSE;
-        else
-                clean_dwfl_info();
	 return TRUE;
}

And then we can remove search routine from init_dwarf_info(). What do
you think?

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
