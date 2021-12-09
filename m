Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvNiP-00H6k4-4J
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 18:00:22 +0000
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
Date: Thu, 9 Dec 2021 14:59:52 -0300
MIME-Version: 1.0
In-Reply-To: <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
Content-Language: en-US
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, kasong@redhat.com, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>

On 09/12/2021 14:31, Alex Deucher wrote:
> [...] 
> Once the driver takes over, none of the pre-driver state is retained.
> You'll need to load the driver in the new kernel to initialize the
> displays.  Note the efifb doesn't actually have the ability to program
> any hardware, it just takes over the memory region that was used for
> the pre-OS framebuffer and whatever display timing was set up by the
> GOP driver prior to the OS loading.  Once that OS driver has loaded
> the area is gone and the display configuration may have changed.
> 

Hi Christian and Alex, thanks for the clarifications!

Is there any way to save/retain this state before amdgpu takes over?
Would simpledrm be able to program the device again, to a working state?

Finally, do you have any example of such a GOP driver (open source) so I
can take a look? I tried to find something like that in Tianocore
project, but didn't find anything that seemed useful for my issue.

Thanks again!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
