Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a694o-0000En-DX
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 03:36:31 +0000
Date: Tue, 8 Dec 2015 11:36:04 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3] vmcore-dmesg: Collect full dmesg regardless of
 logged_chars
Message-ID: <20151208033604.GA3052@dhcp-128-65.nay.redhat.com>
References: <1446023724-12445-1-git-send-email-dliu@redhat.com>
 <1447824280.2500.1.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1447824280.2500.1.camel@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, dliu@redhat.com

On 11/18/15 at 01:24pm, Dangyi Liu wrote:
> Simon,
> =

> Could you help to review this patch?
> =

> Thanks,
> Dangyi Liu
> =

> On Wed, 2015-10-28 at 17:15 +0800, Dangyi Liu wrote:
> > logged_chars would be set to 0 by `dmesg -c`, but full dmesg is
> > useful
> > for debugging. So instead of using logged_chars directly, we
> > calculate
> > it by ourselves.
> > =

> > Now logged_chars is set to the minimum of log_end and log_buf_len, as
> > the same logic as crash utility is using.
> > =

> > Signed-off-by: Dangyi Liu <dliu@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > ---
> > Changes:
> > =A0 v1->v2: Update comment and commit message.
> > =A0 v2->v3: Adjust maximum line length
> > =

> > =A0vmcore-dmesg/vmcore-dmesg.c | 6 ++++++
> > =A01 file changed, 6 insertions(+)
> > =

> > diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-
> > dmesg.c
> > index f47ee11..0364636 100644
> > --- a/vmcore-dmesg/vmcore-dmesg.c
> > +++ b/vmcore-dmesg/vmcore-dmesg.c
> > @@ -540,6 +540,12 @@ static void dump_dmesg_legacy(int fd)
> > =A0		exit(53);
> > =A0	}
> > =A0
> > +	/*
> > +	=A0* To collect full dmesg including the part before `dmesg
> > -c` is useful
> > +	=A0* for later debugging. Use same logic as what crash utility
> > is using.
> > +	=A0*/
> > +	logged_chars =3D log_end < log_buf_len ? log_end :
> > log_buf_len;
> > +
> > =A0	write_to_stdout(buf + (log_buf_len -=A0=A0logged_chars),
> > logged_chars);
> > =A0}
> > =A0
> =


Simon,

What's your opinion about this patch? It is a rh internal report.
Current code make sense, adding the patch will be slight better though
for kdump case. But if you do not like it we can ignore it and close
the bug.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
