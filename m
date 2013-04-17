Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x22c.google.com ([2607:f8b0:4001:c03::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USVEK-0000kU-HA
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 16:29:09 +0000
Received: by mail-ie0-f172.google.com with SMTP id c10so2130040ieb.17
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 09:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3354091.h1CDj18vOb@skinner.arch.suse.de>
References: <3354091.h1CDj18vOb@skinner.arch.suse.de>
Date: Wed, 17 Apr 2013 09:29:06 -0700
Message-ID: <CAE9FiQXXFupeMLm0irwtfchM0FsQhzPMfHpE0fwfO-0Z=hFtaQ@mail.gmail.com>
Subject: Re: reserved crash memory above #define DEFAULT_BZIMAGE_ADDR_MAX
 0x37FFFFFF
From: Yinghai Lu <yinghai@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Thomas Renninger <trenn@suse.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Apr 17, 2013 at 6:52 AM, Thomas Renninger <trenn@suse.de> wrote:
> Hi,
>
> while trying to switch to kvm setup with a latest kernel I realized that
> blank:
> crashkernel=64M
> param will reserve this memory area:
> 7b000000-7effffff : Crash kernel
>
> and kexec does not successfully load the kernel due to (hole_max output
> added myself):
> Could not find a free area of memory of 4c1000 bytes, hole_max: 0x37ffffff...
> locate_hole failed

https://patchwork.kernel.org/patch/2447581/
https://patchwork.kernel.org/patch/2447561/
https://patchwork.kernel.org/patch/2447571/
https://patchwork.kernel.org/patch/2447591/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
