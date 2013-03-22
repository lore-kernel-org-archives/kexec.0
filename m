Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UJ9Uw-000135-R0
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 21:27:39 +0000
Message-ID: <514CCCB8.4000108@zytor.com>
Date: Fri, 22 Mar 2013 14:27:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump, x86: Process multiple Crash kernel in /proc/iomem
References: <20130320163131.GE2273@redhat.com>
 <1363807494-25127-1-git-send-email-yinghai@kernel.org>
 <20130322175925.GA10004@redhat.com>
 <CAE9FiQXZP0zbGA=nTg6bHG29sJJRvzNHHbBi1WUsO60cksSUSQ@mail.gmail.com>
 <20130322212104.GI4544@redhat.com>
In-Reply-To: <20130322212104.GI4544@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On 03/22/2013 02:21 PM, Vivek Goyal wrote:
> 
> BTW, I had a query about loading 64bit entry point bzImage. In 32bit
> bzImage entry point logic, we used to load bzImage at the beginning
> of memory hole and initrd at the end of memory hole. So that bzImage
> and initramfs are as far as possible and initramfs decompression does
> not overwrite anything or for that matter setting bss are does not
> spill over into initramfs.
> 
> In new code, It looks like we seem to be loading kernel towards the end
> of the hole.
> 
>        addr = add_buffer(info, kernel + kern16_size, k_size,
>                           size, align, 0x100000, -1, -1);
> 
> IIUC, this has potential that new kernel can overwrite some of the old
> kernel's data structure while setting up bss. Shouldn't we do it 32bit
> entry code way where bzImage is loaded towards the beginning of hole and
> initramfs is loaded towards the end of the hole.
> 

Since boot protocol 2.10+ the kernel actively exports how much memory it
needs during its setup phase.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
