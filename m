Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIT5W-0008Oq-Ni
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 00:10:36 +0000
Received: by mail-pb0-f46.google.com with SMTP id uo15so1748492pbc.5
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 17:10:32 -0700 (PDT)
Date: Wed, 20 Mar 2013 17:10:30 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: linux-next: Tree for Mar 20 (vmcore)
In-Reply-To: <alpine.DEB.2.02.1303201153330.17761@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.02.1303201709440.23363@chino.kir.corp.google.com>
References: <20130320160536.54e62fc11a3651494b710e3b@canb.auug.org.au>
 <5149E813.8060307@infradead.org>
 <alpine.DEB.2.02.1303201153330.17761@chino.kir.corp.google.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 20 Mar 2013, David Rientjes wrote:

> I don't think that's it, linux/kexec.h already gets included indirectly.  
> The problem is that CONFIG_KEXEC isn't set so the definition in kexec.h is 
> meaningless.
> 
> This comes from "vmcore: check NT_VMCORE_PAD as a mark indicating the end 
> of ELF note buffer" merged through the -mm tree.  I've added the patch's 
> author and Andrew to the cc.
> 
> How can this be protected by CONFIG_KEXEC?
> 

These patches were removed from -mm today so it should no longer be a 
problem.

If the patchset is reintroduced, please keep this build failure in the 
back of your mind, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
