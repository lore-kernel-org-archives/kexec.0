Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TtPNM-0007D9-NH
 for kexec@lists.infradead.org; Thu, 10 Jan 2013 21:09:25 +0000
Date: Thu, 10 Jan 2013 16:09:23 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1268295784.3657868.1357852163361.JavaMail.root@redhat.com>
In-Reply-To: <1906730150.3445569.1357844143086.JavaMail.root@redhat.com>
Subject: Re: makedumpfile bug with ppc64 CONFIG_SPARSEMEM_EXTREME
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>, CAI Qian <caiqian@redhat.com>



----- Original Message -----
> 
> Our QA group recently ran into a makedumpfile problem while
> testing kdump/makedumpfile w/upstream 3.7.1 kernels, which
> had to do with the filtering of pages on a 12GB ppc64 system.
>
... [ cut ] ...
> 
> I haven't checked why the original math fails in the case of the
> ppc64 kernel, while it does not fail in a CONFIG_SPARSEMEM_EXTREME
> x86_64 kernel, for example. (page size maybe?)  But obviously the
> simpler dimemsion-check is a better way to do it.
> 
> Of course, within the current constraints of makedumpfile, it's not
> that easy.  Ideally the kernel could pass the configuration in
> the vmcoreinfo with a VMCOREINFO_CONFIG(name).  But anyway, I'll leave
> that up to you.
> 
> Thanks,
>   Dave

It's presumably being seen in 3.7.1 because of this commit:

  $ git log -p arch/powerpc/include/asm/sparsemem.h
  commit 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4
  Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
  Date:   Mon Sep 10 02:52:55 2012 +0000

      powerpc/mm: Add 64TB support
    
      Increase max addressable range to 64TB. This is not tested on
      real hardware yet.
    
      Reviewed-by: Paul Mackerras <paulus@samba.org>
      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
      Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

  diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
  index 0c5fa31..f6fc0ee 100644
  --- a/arch/powerpc/include/asm/sparsemem.h
  +++ b/arch/powerpc/include/asm/sparsemem.h
  @@ -10,8 +10,8 @@
    */
   #define SECTION_SIZE_BITS       24
 
  -#define MAX_PHYSADDR_BITS       44
  -#define MAX_PHYSMEM_BITS        44
  +#define MAX_PHYSADDR_BITS       46
  +#define MAX_PHYSMEM_BITS        46
 
   #endif /* CONFIG_SPARSEMEM */

  $ git describe --contains 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4
  v3.7-rc1~108^2~32
  $
  
Dave




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
