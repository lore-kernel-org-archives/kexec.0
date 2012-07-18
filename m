Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SrY28-00037x-Gc
 for kexec@lists.infradead.org; Wed, 18 Jul 2012 17:27:48 +0000
Received: by pbbrq13 with SMTP id rq13so3137053pbb.36
 for <kexec@lists.infradead.org>; Wed, 18 Jul 2012 10:27:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120718171812.GC21746@redhat.com>
References: <20120718171812.GC21746@redhat.com>
From: Kay Sievers <kay@vrfy.org>
Date: Wed, 18 Jul 2012 19:27:08 +0200
Message-ID: <CAPXgP12PioibfQhtAB0fCzL1MXmZvfvQqOGu_ZM0D8Sx4Vq7+w@mail.gmail.com>
Subject: Re: [PATCH] printk: Export struct log size and member offsets through
 vmcoreinfo
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Greg Kroah-Hartmann <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Jul 18, 2012 at 7:18 PM, Vivek Goyal <vgoyal@redhat.com> wrote:

> Currently I am not exporting log "level" info as that is a bitfield and
> offsetof() bitfields can't be calculated.

We could make the level the lower 3 bits of the byte, export the byte,
and define that only 3 bits of the byte are valid? Would that help?

>  kernel/printk.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

> +       /*
> +        * Export struct log size and field offsets. User space tools can
> +        * parse it and detect any changes to structure down the line.
> +        */
> +       VMCOREINFO_STRUCT_SIZE(log);
> +       VMCOREINFO_OFFSET(log, ts_nsec);
> +       VMCOREINFO_OFFSET(log, len);
> +       VMCOREINFO_OFFSET(log, text_len);
> +       VMCOREINFO_OFFSET(log, dict_len);

Ah, nice, that's how you handle exporting structures, it was still on
my list, to find out how all that should look like.

Cc:ing Greg, to pick it up.

Thanks a lot for taking care of it,
Kay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
