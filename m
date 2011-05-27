Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1Tq-0005yH-9j
	for kexec@lists.infradead.org; Fri, 27 May 2011 18:09:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171521.GD17988@in.ibm.com>
Date: Fri, 27 May 2011 11:09:44 -0700
In-Reply-To: <20110526171521.GD17988@in.ibm.com> (K. Prasad's message of "Thu, 
	26 May 2011 22:45:21 +0530")
Message-ID: <m1vcww817b.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC Patch 4/6] PANIC_MCE: Introduce a new panic flag for fatal
	MCE, capture related information
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
To: prasad@linux.vnet.ibm.com
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> PANIC_MCE: Introduce a new panic flag for fatal MCE, capture related information
>
> Fatal machine check exceptions (caused due to hardware memory errors) will now
> result in a 'slim' coredump that captures vital information about the MCE. This
> patch introduces a new panic flag, and new parameters to *panic functions
> that can capture more information pertaining to the cause of crash.
>
> Enable a new elf-notes section to store additional information about the crash.
> For MCE, enable a new notes section that captures relevant register status
> (struct mce) to be later read during coredump analysis.
>
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>


> -void crash_save_vmcoreinfo(void)
> +void crash_save_vmcoreinfo(void *arch_info, size_t arch_info_size,
> +						enum panic_flags flags)
>  {
>  	u32 *buf;
>  
> @@ -1392,9 +1394,12 @@ void crash_save_vmcoreinfo(void)
>  
>  	buf = (u32 *)vmcoreinfo_note;
>  
> -	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
> -			      vmcoreinfo_size);
> -
> +	if (flags & PANIC_MCE)
> +		buf = append_elf_note(buf, "PANIC_MCE", NT_MCE, arch_info,
> +					arch_info_size);

Ok.  This is uglier than I thought.  You have this terribly generic
interface than when you go to use it you assume it is an mce.  Ugh
no.

Furthermore you short circuit out other pieces of this code.

This patch is a total hack that is massively over engineered.

Saving NT_MCE is fine, in and of itself.  The rest of the information
is totally nonsense.

Eric


> +	else
> +		buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0,
> +				vmcoreinfo_data, vmcoreinfo_size);
>  	final_note(buf);
>  }
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
