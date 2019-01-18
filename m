Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkTMI-0005Du-0y
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 12:34:51 +0000
Date: Fri, 18 Jan 2019 20:34:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
Message-ID: <20190118123437.GA30929@dhcp-128-65.nay.redhat.com>
References: <20190118091733.29940-1-kasong@redhat.com>
 <1547812432.3982.55.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547812432.3982.55.camel@linux.ibm.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

On 01/18/19 at 06:53am, Mimi Zohar wrote:
> On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component cou=
ld
> > use this keyring as well.
> =

> Kairui, when people review patches, the comments could be specific,
> but are normally generic. =A0My review included a couple of generic
> suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> term "preboot" keys, and remove any references to "other components".
> =

> After all the wording suggestions I've made, you are still saying, "So
> other components could use this keyring as well".=A0=A0Really?! =A0How the
> platform keyring will be used in the future, is up to you and others
> to convince Linus. =A0At least for now, please limit its usage to
> verifying the PE signed kernel image. =A0If this patch set needs to be
> reposted, please remove all references to "other components".
> =

> Dave/David, are you ok with Kairui's usage of "#ifdef's"? =A0Dave, you
> Acked the original post. =A0Can I include it? =A0Can we get some
> additional Ack's on these patches?

It is better to update patch to use IS_ENABLED in patch 1/2 as well.
Other than that, for kexec part I'm fine with an ack.
 =

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
