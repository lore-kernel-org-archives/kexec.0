Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hO1qg-0002JW-Rl
 for kexec@lists.infradead.org; Tue, 07 May 2019 15:17:44 +0000
Received: by mail-qt1-x843.google.com with SMTP id d20so1894589qto.2
 for <kexec@lists.infradead.org>; Tue, 07 May 2019 08:17:41 -0700 (PDT)
Date: Tue, 7 May 2019 11:17:38 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [SeaBIOS] Real mode kexec failure with non-IDE disk
Message-ID: <20190507151738.GB20031@morn.lan>
References: <e5872703412f9a56c10df52d9793ca2a6401d7f0.camel@infradead.org>
 <20190501025601.GA5342@morn.lan>
 <1689977da7b323b360c35fc021a67e766c3347bb.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1689977da7b323b360c35fc021a67e766c3347bb.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: seabios@seabios.org, kexec <kexec@lists.infradead.org>

Hi David,

On Wed, May 01, 2019 at 11:16:03PM +0300, David Woodhouse wrote:
> On Tue, 2019-04-30 at 22:56 -0400, Kevin O'Connor wrote:
> > That call trace certainly looks odd.  The SeaBIOS debugging info would
> > help - try compiling SeaBIOS with debug level 8 and grab the log (as
> > described at: https://www.seabios.org/Debugging#Diagnostic_information
> > ).
> 
> Choosing Xen because it actually succeeds, while Linux real-mode boot
> then dies a bit later even if I use IDE disks...
[...]
>The full log from boot (including the boot
> of the first kernel) is at http://david.woodhou.se/smi-wtf.txt

From that log, it doesn't look like SeaBIOS itself is reset during the
kexec.  I could be wrong, but here's my understanding of that log:

- SeaBIOS starts normally and initializes the virtio-blk device

- SeaBIOS hands control to the bootloader.  The bootloader makes
  various BIOS calls that read blocks from the virtio-blk device.

- At some point the bootloader loads Linux.  Linux reinitializes the
  virtio-blk device to its liking.

- At some point, a kexec occurs and then SeaBIOS gets a request to
  read data from the virtio-blk device.  However, the virtio-blk
  device was reset by Linux, so the SeaBIOS' device structures are no
  longer valid.

- SeaBIOS waits indefinitely for a virtio notify event that it wont
  ever receive (because it is waiting on a control structure that the
  virtio-blk device is no longer configured to use).

If SeaBIOS doesn't get a signal to reinitialize itself, I'm not sure
there's much it can do in that situation.  (Though, as above, it's
possible I've misread the log.)

Cheers,
-Kevin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
