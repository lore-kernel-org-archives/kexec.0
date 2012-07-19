Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SrrEp-0000Dy-Cv
 for kexec@lists.infradead.org; Thu, 19 Jul 2012 13:57:59 +0000
Date: Thu, 19 Jul 2012 09:57:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] printk: Export struct log size and member offsets
 through vmcoreinfo
Message-ID: <20120719135736.GC2761@redhat.com>
References: <20120718171812.GC21746@redhat.com>
 <CAPXgP12PioibfQhtAB0fCzL1MXmZvfvQqOGu_ZM0D8Sx4Vq7+w@mail.gmail.com>
 <20120718175625.GD21746@redhat.com>
 <CAPXgP12YasX6mBVOamO8Tk1mcFJ04XWh5CjuTRxhRShncgVCtA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPXgP12YasX6mBVOamO8Tk1mcFJ04XWh5CjuTRxhRShncgVCtA@mail.gmail.com>
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
To: Kay Sievers <kay@vrfy.org>
Cc: Greg Kroah-Hartmann <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Jul 19, 2012 at 11:38:57AM +0200, Kay Sievers wrote:
> On Wed, Jul 18, 2012 at 7:56 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Wed, Jul 18, 2012 at 07:27:08PM +0200, Kay Sievers wrote:
> >> On Wed, Jul 18, 2012 at 7:18 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> >>
> >> > Currently I am not exporting log "level" info as that is a bitfield and
> >> > offsetof() bitfields can't be calculated.
> >>
> >> We could make the level the lower 3 bits of the byte, export the byte,
> >> and define that only 3 bits of the byte are valid? Would that help?
> >
> > Yes, that should work. Here is the prototype patch which stores 5 bits
> > of flag and 3 bits of level in a byte. I have not tested it yet, but
> > if you like the approach, I will test it.
> 
> > -       u8 flags:5;             /* internal record flags */
> > -       u8 level:3;             /* syslog level */
> > +       u8 flags_level;         /* 5 bit internal record flags, 3 bits syslog
> 
> Looks ok.
> 
> If we would swap the 5 + 3 bit field byte declaration, and add
> __packed, we can still not rely on the level to be consistently the
> lower 3 bits of the byte, right?

Current code assumes that level bits are least significant bits in
flags_level. I could export another field say "log_level_bit_offset=0" to
represent the offset of level bits and that way you will retain the
flexibilty of changing the position of level bits. I am not sure if it
is worth. Down the line if numeber of flags outgrow 5bits, one can 
just move flags to a separate field and possibly use those 5bits for
something else.

I guess I will change the patch to also level bit offset and remove
the assumption that level bits are always starting at offset 0. Will test
changes and repost the V2 of patches.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
