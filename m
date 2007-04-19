Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [ANNOUNCE] kexec mailing list
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070419030217.GA7754@verge.net.au>
References: <20070419030217.GA7754@verge.net.au>
Date: Wed, 18 Apr 2007 22:23:50 -0500
Message-Id: <1176953030.21611.107.camel@shinybook.infradead.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@in.ibm.com>, fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, 2007-04-19 at 12:02 +0900, Simon Horman wrote:
> 
> David advises me that there are two spam-reduction rules that users
> should keep in mind:
> 
>   * No attachments
>     Please send patches and the like inline in accordance with
>     the patch sumission guidelines that can be found at.

To be precise: mail with types text/html and multipart/* are all trapped
for moderation. Whether they get through or not are up to the whim of
the moderator. I'm not sure I'd express that as "no attachments", but if
you want your mail to go straight through instead of waiting for Simon
or I to approve it, then including a patch inline instead of attaching
it might be a good idea.

>     On the topic of patch submission. I think it would be
>     good if kernel and user-space patches alike followed
>     the guidelines at:
>     http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
> 
>   * If there is an "Re: " in the subject then there must also
>     be a "References:" header
   ... or an In-Reply-To: header. One or the other will suffice -- which
means that if you reply by clicking on a mailto: link in the archive,
you should be OK because those links have correct In-Reply-To: in the
URL and you'll preserve the threading information correctly.

Conversely, anything with References: or In-Reply-To: headers should
have 'Re: ' in the subject to avoid being trapped for moderation. That's
a rule used on higher-traffic mailing lists where some muppets make a
habit of replying to existing threads and changing the subject, when
they should have started a new thread instead. 

We could perhaps drop that rule for this list, since it conflicts with
what's generally considered to be the good practice of sending sets of
patches in a 'thread' with the second and subsequent ones bearing the
Message-Id of the first in their References:. It's just a question of
how much manual approval the moderator can be bothered to deal with :)

Anyway, these are all just the settings inherited from other lists.
They're subject to change -- we could relax the rules for a low-volume
list if we want to; I'll leave it up to Simon.

The only rules which are really enforced system-wide are that incoming
messages must have a Message-Id: header, and must come from a valid
address which actually accepts bounces (MAIL FROM:<>). But those are
just common sense.

-- 
dwmw2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
