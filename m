Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giUl7-00071e-EL
 for kexec@lists.infradead.org; Sun, 13 Jan 2019 01:40:18 +0000
Date: Sun, 13 Jan 2019 09:39:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
Message-ID: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547223220.19931.471.camel@linux.ibm.com>
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

Hi,

On 01/11/19 at 11:13am, Mimi Zohar wrote:
> On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> [snip]
> =

> > Personally I would like to see platform key separated from integrity.
> > But for the kexec_file part I think it is good at least it works with
> > this fix.
> > =

> > Acked-by: Dave Young <dyoung@redhat.com>
> =

> The original "platform" keyring patches that Nayna posted multiple
> times were in the certs directory, but nobody commented/responded. =A0So
> she reworked the patches, moving them to the integrity directory and
> posted them (cc'ing the kexec mailing list). =A0It's a bit late to be
> asking to move it, isn't it?

Hmm, apologize for being late,  I did not get chance to have a look the
old series.  Since we have the needs now, it should be still fine

Maybe Kairui can check Nayna's old series, see if he can do something
again?

> =

> Mimi
> =


Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
