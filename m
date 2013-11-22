Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjf2I-0002Sd-3w
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 00:55:55 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 405393EE0B6
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:55:32 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2B71F45DE54
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:55:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 132B945DE4D
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:55:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id F243A1DB803E
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:55:31 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A4CD21DB803A
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:55:31 +0900 (JST)
Message-ID: <528EAB73.9010700@jp.fujitsu.com>
Date: Fri, 22 Nov 2013 09:55:15 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

(2013/11/21 2:50), Vivek Goyal wrote:
> Current proposed secureboot implementation disables kexec/kdump because
> it can allow unsigned kernel to run on a secureboot platform. Intial
> idea was to sign /sbin/kexec binary and let that binary do the kernel
> signature verification. I had posted RFC patches for this apparoach
> here.
>
> https://lkml.org/lkml/2013/9/10/560
>
> Later we had discussion at Plumbers and most of the people thought
> that signing and trusting /sbin/kexec is becoming complex. So a
> better idea might be let kernel do the signature verification of
> new kernel being loaded. This calls for implementing a new system call
> and moving lot of user space code in kernel.
>
> kexec_load() system call allows loading a kexec/kdump kernel and jump
> to that kernel at right time. Though a lot of processing is done in
> user space which prepares a list of segments/buffers to be loaded and
> kexec_load() works on that list of segments. It does not know what's
> contained in those segments.
>
> Now a new system call kexec_file_load() is implemented which takes
> kernel fd and initrd fd as parameters. Now kernel should be able
> to verify signature of newly loaded kernel.
>
> This is an early RFC patchset. I have not done signature handling
> part yet. This is more of a minimal patch to show how new system
> call and functionality will look like. Right now it can only handle
> bzImage with 64bit entry point on x86_64. No EFI, no x86_32  or any
> other architecture. Rest of the things can be added slowly as need
> arises. In first iteration, I have tried to address most common use case
> for us.
>
> Any feedback is welcome.
>

So, ultimately on this design direction, user-land kexec command someday
will no longer be used at all? Or is there any feature you will keep in
user-land side?

I think it big change if one component in kdump will disappear.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
