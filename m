Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from h2.hallyn.com ([78.46.35.8] helo=mail.hallyn.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fPvDR-0001BD-P7
 for kexec@lists.infradead.org; Mon, 04 Jun 2018 19:32:32 +0000
Date: Mon, 4 Jun 2018 14:32:15 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
Message-ID: <20180604193215.GA13553@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1528121025.3237.116.camel@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Andres Rodriguez <andresx7@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, James Morris <james.l.morris@oracle.com>, Jessica Yu <jeyu@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, "Serge E. Hallyn" <serge@hallyn.com>

Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
> > Instead of adding the security_kernel_read_file LSM hook - or defining a
> > wrapper for security_kernel_read_file LSM hook and adding it, or
> > renaming the existing hook to security_kernel_read_data() and adding it
> > - in places where the kernel isn't reading a file, this version of the
> > patch set defines a new LSM hook named security_kernel_load_data().
> > =

> > The new LSM hook does not replace the existing security_kernel_read_file
> > LSM hook, which is still needed, but defines a new LSM hook allowing
> > LSMs and IMA-appraisal the opportunity to fail loading userspace
> > provided file/data.
> > =

> > The only difference between the two LSM hooks is the LSM hook name and a
> > file descriptor.  Whether this is cause enough for requiring a new LSM
> > hook, is left to the security community.
> =

> Paul does not have a preference as to adding a new LSM hook or calling
> the existing hook. =A0Either way is fine, as long as both the new and
> existing hooks call the existing function.
> =

> Casey didn't like the idea of a wrapper.
> James suggested renaming the LSM hook.
> =

> The maintainers for the callers of the LSM hook prefer a meaningful
> LSM hook name. =A0The "null" argument is not as much of a concern. =A0Only
> Eric seems to be asking for a separate, new LSM hook, without the
> "null" argument.
> =

> Unless someone really objects, to accommodate Eric we'll define a new
> LSM hook named security_kernel_load_data. =A0Eric, are you planning on

I'm confused - isn't that what this patchset did? :)

> Ack'ing patches 1 & 2?
> =

> Mimi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
