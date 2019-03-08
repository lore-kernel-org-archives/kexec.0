Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h25VL-0004oC-3h
 for kexec@lists.infradead.org; Fri, 08 Mar 2019 02:45:00 +0000
Date: Fri, 8 Mar 2019 10:44:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
Message-ID: <20190308024450.GC7223@dhcp-128-65.nay.redhat.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
 <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
 <1551366343.10911.173.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551366343.10911.173.camel@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org

On 02/28/19 at 10:05am, Mimi Zohar wrote:
> Hi Dave,
> =

> On Thu, 2019-02-28 at 21:41 +0800, Dave Young wrote:
> > Hi Mimi,
> >  =

> > Sorry for jumping in late, just noticed this kexec selftests, I think we
> > also need a kexec load test not only for ima, but for general kexec
> =

> The IMA kselftest tests are for the coordination between the different
> methods of verifying file signatures. =A0In particular, for the kexec
> kernel image and kernel module signatures.
> =

> The initial IMA kselftest just verifies that in an environment
> requiring signed kexec kernel images, the kexec_load syscall fails.=A0
> =

> This week I posted additional IMA kselftests[1][2], including one for
> the kexec_file_load syscall. =A0I would really appreciate these
> kselftests being reviewed/acked.
> =

> Mimi
> =

> [1] Subject: [PATCH v2 0/5] selftests/ima: add kexec and kernel module te=
sts
> [2] Patches available from the "next-queued-testing" branch
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/
> =


Hi Mimi,

Still did not get change to have a look at V2,  but seems you missed the
last chunk of comments about the secure boot mode in previous reply?

I just copy it hear:
'''
Do you want to get the Secureboot status here?
I got some advice from Peter Jones previously, thus we have below
in our kdump scripts:
https://src.fedoraproject.org/cgit/rpms/kexec-tools.git/tree/kdump-lib.sh

See the function is_secure_boot_enforced(), probably you can refer to
that function and check setup mode as well.
'''

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
