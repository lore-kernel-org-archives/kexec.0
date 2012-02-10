Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rvomb-0002sG-3o
 for kexec@lists.infradead.org; Fri, 10 Feb 2012 11:36:54 +0000
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 10 Feb 2012 17:06:46 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1ABagKN2232412
 for <kexec@lists.infradead.org>; Fri, 10 Feb 2012 17:06:43 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1ABag9r007340
 for <kexec@lists.infradead.org>; Fri, 10 Feb 2012 17:06:42 +0530
Message-ID: <4F350143.1090508@in.ibm.com>
Date: Fri, 10 Feb 2012 17:06:35 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/3] [makedumpfile] Add support for PPC32
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
 <20120118100949.29422.17463.stgit@suzukikp.in.ibm.com>
 <20120210184543.fbb08606.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120210184543.fbb08606.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: usui@mxm.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

On 02/10/2012 03:15 PM, Atsushi Kumagai wrote:
> Hi, Suzuki
>
> On Wed, 18 Jan 2012 15:40:03 +0530
> "Suzuki K. Poulose"<suzuki@in.ibm.com>  wrote:
>
>> Mostly a copy of ppc64 with renaming to _ppc variants.
>>
>> Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
>> ---
>>
>>   Makefile       |   11 ++++--
>>   arch/ppc.c     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   makedumpfile.c |    4 +-
>>   makedumpfile.h |   24 ++++++++++++-
>>   4 files changed, 133 insertions(+), 7 deletions(-)
>>   create mode 100644 arch/ppc.c
>
> I will make small changes:
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index cefb7cf..901b85c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5693,7 +5693,7 @@ initial_xen(void)
>
>   #if defined(__powerpc64__) || defined(__powerpc32__)
>          MSG("\n");
> -       MSG("xen is not supported on powerpc.\n");
> +       MSG("Xen is not supported on powerpc.\n");
>          return FALSE;
>   #else
>          if(!info->flag_elf_dumpfile) {
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 88b7bc2..e43ea84 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -686,7 +686,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
>   #define get_machdep_info()     get_machdep_info_ppc()
>   #define get_versiondep_info()  TRUE
>   #define vaddr_to_paddr(X)      vaddr_to_paddr_ppc(X)
> -#endif          /* powerpc */
> +#endif          /* powerpc32 */
>
>   #ifdef __s390x__ /* s390x */
>   int get_machdep_info_s390x(void);
>
>
> The other parts looks good.
> I will merge this patch to makedumpfile-1.4.3.
>
> By the way, could you tell me kernel versions that you've tested ?
> I want to update "SUPPORTED KERNELS" in the README.

I have tested this on 3.2.0. Eventhough the makedumpfile says the kernel
is not supported, the dumps work fine.

Thanks
Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
