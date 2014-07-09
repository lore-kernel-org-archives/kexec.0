Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4uM1-0000u0-3D
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 16:04:23 +0000
Date: Wed, 9 Jul 2014 18:03:49 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 00/17] KEYS: PKCS#7 and PE file signature checking for
 kexec
Message-ID: <20140709160349.GA5292@pd.tnic>
References: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
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
To: David Howells <dhowells@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: keyrings@linux-nfs.org, x86-ml <x86@kernel.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

On Wed, Jul 09, 2014 at 04:15:25PM +0100, David Howells wrote:
> David Howells (16):
>       X.509: Add bits needed for PKCS#7
>       X.509: Export certificate parse and free functions
>       PKCS#7: Implement a parser [RFC 2315]
>       PKCS#7: Digest the data in a signed-data message
>       PKCS#7: Find the right key in the PKCS#7 key list and verify the signature
>       PKCS#7: Verify internal certificate chain
>       PKCS#7: Find intersection between PKCS#7 message and known, trusted keys
>       PKCS#7: Provide a key type for testing PKCS#7
>       KEYS: X.509: Fix a spelling mistake
>       Provide PE binary definitions
>       pefile: Parse a PE binary to find a key and a signature contained therein
>       pefile: Strip the wrapper off of the cert data block
>       pefile: Parse the presumed PKCS#7 content of the certificate blob
>       pefile: Parse the "Microsoft individual code signing" data blob
>       pefile: Digest the PE binary and compare to the PKCS#7 data
>       pefile: Validate PKCS#7 trust chain
> 
> Vivek Goyal (1):
>       pefile: Handle pesign using the wrong OID

let me see if I get this straight:

this current submission is supposed to replace

http://lkml.kernel.org/r/20140708131504.28621.61165.stgit@warthog.procyon.org.uk

and Vivek's one:

http://lkml.kernel.org/r/1404421641-12691-1-git-send-email-vgoyal@redhat.com

(which added those parsers to arch/x86/kernel/ - not a good place anyway.)

?

The kexec bits with the sig verif will come ontop, it seems. What's the
story guys?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
