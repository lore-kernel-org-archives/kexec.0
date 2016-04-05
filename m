Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1anNNk-0003uw-2D
 for kexec@lists.infradead.org; Tue, 05 Apr 2016 09:34:45 +0000
Date: Tue, 5 Apr 2016 11:34:33 +0200
From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
Subject: Re: [PATCH 1/3] arm: properly handle a missing /chosen node in the DT
Message-ID: <20160405093433.GA14598@avionic-0071.adnet.avionic-design.de>
References: <1459438260-8205-1-git-send-email-alban.bedel@avionic-design.de>
 <20160405063306.GA19694@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160405063306.GA19694@verge.net.au>
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
Cc: kexec@lists.infradead.org, Alban Bedel <alban.bedel@avionic-design.de>

On Tue, Apr 05, 2016 at 03:33:06PM +0900, Simon Horman wrote:
> On Thu, Mar 31, 2016 at 05:30:58PM +0200, Alban Bedel wrote:
> > From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> > =

> > When adding a new node to the DT in the setup_dtb_prop function, the
> > parent offset need be passed to fdt_add_subnode.  Currently a bogus
> > error code is used.  Fix that by adding the parent offset as an extra
> > function argument to setup_dtb_prop, and change the handling of the
> > /chosen node to operate on a relative path plus (zero) offset instead of
> > an absolute path.
> > =

> > Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
> =

> Hi,
> =

> I am struggling to see the problem that this patch tries to solve.
> =

> * Where and when is a bogus error code used?

Hi Simon!

The bogus error code is passed to fdt_add_subnode, see comment inline in
the patch below.

> * Why is a new parameter added to fdt_add_subnode and always passed as ze=
ro?

Yeah, this might look irritating... the point is, setup_dtb_prop looks
like a generic function that could be used for finding/adding any nodes,
which need not be top-level in the DT.  In practice though, the function
is only used for the top-level /chosen node, and currently it can't add
nodes that aren't top-level.

So, one could either a) make the function non-generic, handling
top-level nodes only, or b) pass it the offset of the parent node, or c)
let it operate on aribtrary DT paths with possibly multiple components.
a) and b) are trivial to do.  libfdt typically does b) for similar
functions, so I added that extra parameter to fdt_add_subnode.

> * If it is inappropriate to pass off to fdt_add_subnode() can
>   that be resolved by simply passing 0 instead?

If we know that we're adding a top-level node, then yes.  Basically,
one can do that either in fdt_add_subnode, or when calling it in
zImage_arm_load.  My patch does the latter.

Best regards,
Nikolaus

> > ---
> >  kexec/arch/arm/kexec-zImage-arm.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > =

> > diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-z=
Image-arm.c
> > index d85ab9b..78518fd 100644
> > --- a/kexec/arch/arm/kexec-zImage-arm.c
> > +++ b/kexec/arch/arm/kexec-zImage-arm.c
> > @@ -257,8 +257,9 @@ int atag_arm_load(struct kexec_info *info, unsigned=
 long base,
> >  	return 0;
> >  }
> >  =

> > -static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_=
name,
> > -		const char *prop_name, const void *val, int len)
> > +static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
> > +		const char *node_name, const char *prop_name,
> > +		const void *val, int len)
> >  {
> >  	char *dtb_buf;
> >  	off_t dtb_size;
> > @@ -273,14 +274,14 @@ static int setup_dtb_prop(char **bufp, off_t *siz=
ep, const char *node_name,
> >  	dtb_size =3D *sizep;
> >  =

> >  	/* check if the subnode has already exist */
> > -	off =3D fdt_path_offset(dtb_buf, node_name);
> > +	off =3D fdt_subnode_offset(dtb_buf, parentoffset, node_name);
> >  	if (off =3D=3D -FDT_ERR_NOTFOUND) {
> >  		dtb_size +=3D fdt_node_len(node_name);
> >  		fdt_set_totalsize(dtb_buf, dtb_size);
> >  		dtb_buf =3D xrealloc(dtb_buf, dtb_size);
> >  		if (dtb_buf =3D=3D NULL)
> >  			die("xrealloc failed\n");
> > -		off =3D fdt_add_subnode(dtb_buf, off, node_name);

Here, off =3D=3D -FDT_ERR_NOTFOUND, which makes no sense.

> > +		off =3D fdt_add_subnode(dtb_buf, parentoffset, node_name);
> >  	}
> >  =

> >  	if (off < 0) {
> > @@ -496,7 +497,7 @@ int zImage_arm_load(int argc, char **argv, const ch=
ar *buf, off_t len,
> >  				 *  Error should have been reported so
> >  				 *  directly return -1
> >  				 */
> > -				if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> > +				if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
> >  						"bootargs", command_line,
> >  						strlen(command_line) + 1))
> >  					return -1;
> > @@ -542,11 +543,11 @@ int zImage_arm_load(int argc, char **argv, const =
char *buf, off_t len,
> >  			start =3D cpu_to_be32((unsigned long)(initrd_base));
> >  			end =3D cpu_to_be32((unsigned long)(initrd_base + initrd_size));
> >  =

> > -			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> > +			if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
> >  					"linux,initrd-start", &start,
> >  					sizeof(start)))
> >  				return -1;
> > -			if (setup_dtb_prop(&dtb_buf, &dtb_length, "/chosen",
> > +			if (setup_dtb_prop(&dtb_buf, &dtb_length, 0, "chosen",
> >  					"linux,initrd-end", &end,
> >  					sizeof(end)))
> >  				return -1;
> > -- =

> > 2.8.0
> > =


-- =

Avionic Design GmbH
Nikolaus Schulz
Wragekamp 10
D-22397 Hamburg
Germany

Tel.:  +49 40 88187-163
Fax:   +49 40 88187-150
Email: nikolaus.schulz@avionic-design.de

Avionic Design GmbH
Amtsgericht Hamburg HRB 82598
Gesch=E4ftsf=FChrung: Cornelis Broers
Ust.-Ident-Nr.: DE813378254

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
