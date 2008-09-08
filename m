Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KcgQN-00086J-Li
	for kexec@lists.infradead.org; Mon, 08 Sep 2008 13:04:59 +0000
Date: Mon, 8 Sep 2008 09:04:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH][RFC] vmcore: Remove saved_max_pfn check
Message-ID: <20080908130453.GA3631@redhat.com>
References: <20080908032132.9381.81555.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080908032132.9381.81555.sendpatchset@rx1.opensource.se>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: hbabu@us.ibm.com, horms@verge.net.au, kexec@lists.infradead.org, ebiederm@xmission.com

On Mon, Sep 08, 2008 at 12:21:32PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch removes the saved_max_pfn check from the /proc/vmcore
> function read_from_oldmem(). No need to verify, we should be able
> to just trust that "elfcorehdr=" is correctly passed to the crash
> kernel on the kernel command line like we do with other parameters.
> 
> The read_from_oldmem() function in fs/proc/vmcore.c is quite similar
> to read_from_oldmem() in drivers/char/mem.c, but only in the latter
> it makes sense to use saved_max_pfn. For oldmem it is used to determine
> when to stop reading. For vmcore we already have the elf header info
> pointing out the physical memory regions, no need to pass the end-of-
> old-memory twice.
> 
> Removing the saved_max_pfn check from vmcore makes it possible for
> architectures to skip oldmem but still support crash dump through
> vmcore - without the need for the old saved_max_pfn cruft.
> 
> Architectures that want to play safe can do the saved_max_pfn check
> in copy_oldmem_page(). Not sure why anyone would want to do that,
> but that's even safer than today - the saved_max_pfn check in vmcore
> removed by this patch only checks the first page.
> 

Hi Magnus,

Though I don't feel very strongly for saved_max_pfn check in vmcore.c,
but at the same time I don't understand what are you gaining by removing
this check. Any way we are not getting rid of this symbol altogether
because /dev/oldmem needs it.

Is it sh arch for which you want to disable /dev/oldmem and only enable
/proc/vmcore and hence want to get rid of saved_max_pfn?

Though I agree that we should elfcorehdrs but at the same time it does not
hard doing additional check (We are anyway carrying saved_max_pfn for
/dev/oldmem). We can always extend current code to check for end page also
to make sure we are not reading beyond saved_max_pfn.

How much code is it to set value of saved_max_pfn in sh that you want to
completely get rid of it. My feeling is that it should be just few lines.

So though I don't feel strongly for saved_max_pfn check  in vmcore.c, at
the same time I don't see you are gaining anything significant by removing
it. We can just introduce saved_max_pfn in sh also.

Thanks
Vivek
 


> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  fs/proc/vmcore.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- 0001/fs/proc/vmcore.c
> +++ work/fs/proc/vmcore.c	2008-09-08 11:33:10.000000000 +0900
> @@ -50,8 +50,6 @@ static ssize_t read_from_oldmem(char *bu
>  
>  	offset = (unsigned long)(*ppos % PAGE_SIZE);
>  	pfn = (unsigned long)(*ppos / PAGE_SIZE);
> -	if (pfn > saved_max_pfn)
> -		return -EINVAL;
>  
>  	do {
>  		if (count > (PAGE_SIZE - offset))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
