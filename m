Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvNzi-00HBeh-8O
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 18:18:15 +0000
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
Date: Thu, 9 Dec 2021 15:17:51 -0300
MIME-Version: 1.0
In-Reply-To: <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>

Thanks again Alex! Some comments inlined below:

On 09/12/2021 15:06, Alex Deucher wrote:
> Not really in a generic way.  It's asic and platform specific.  In
> addition most modern displays require link training to bring up the
> display, so you can't just save and restore registers.

Oh sure, I understand that. My question is more like: is there a way,
inside amdgpu driver, to save this state before taking
over/overwriting/reprogramming the device? So we could (again, from
inside the amdgpu driver) dump this pre-saved state in the shutdown
handler, for example, having the device in a "pre-OS" state when the new
kexec'ed kernel starts.

> 
> The drivers are asic and platform specific.  E.g., the driver for
> vangogh is different from renoir is different from skylake, etc.  The
> display programming interfaces are asic specific.

Cool, that makes sense! But if you (or anybody here) know some of these
GOP drivers, e.g. for the qemu/qxl device, I'm just curious to
see/understand how complex is the FW driver to just put the
device/screen in a usable state.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
