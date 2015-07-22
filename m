Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZHjpB-0001Eb-VK
 for kexec@lists.infradead.org; Wed, 22 Jul 2015 02:32:02 +0000
Date: Wed, 22 Jul 2015 10:31:28 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V2 2/2 update] kexec: split kexec_load syscall from kexec
 core code
Message-ID: <20150722023128.GB5107@dhcp-129-220.nay.redhat.com>
References: <20150720083713.528114272@redhat.com>
 <20150720084558.645442047@redhat.com>
 <20150722021900.GB16615@dhcp-128-11.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150722021900.GB16615@dhcp-128-11.nay.redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org
Cc: jwboyer@fedoraproject.org, tytso@mit.edu, ptesarik@suse.cz, dhowells@redhat.com, geert@linux-m68k.org, ebiederm@xmission.com, vgoyal@redhat.com

On 07/22/15 at 10:19am, Dave Young wrote:
> ---
> 
> Update per comments from Vivek:
> - Moved below functions which are used by kexec_load only to kexec.c
>   copy_user_segment_list() and kimage_alloc_init() 
> - add slab.h to kexec.c because kimage_alloc_init will call kfree
> - drop unused declaration of kimage_alloc_init in kexec.h
> 
[snip]

Andrew, I noticed you have taken the two patches in -mm, could you
replace the 2/2 with this update, there's small cleanup per Vivek's
comments, detail changes see above.

BTW, sorry I forgot to remove the "Re: " before "[PATCH]" prefix.

Thanks
Dave

thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
