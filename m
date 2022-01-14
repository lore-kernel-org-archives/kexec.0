From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Jan 2022 15:55:48 +0100
Subject: [PATCH 1/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
In-Reply-To: <YdxsXlGW9QVeiMv1@osiris>
References: <20211208125355.256391-1-egorenar@linux.ibm.com>
 <20211213114430.77f28a67@rhtmp>
 <20211215124300.GA4314@vergenet.net> <YboqYTz8NziIYJwC@osiris>
 <87mtk3lina.fsf@oc8242746057.ibm.com> <YdxsXlGW9QVeiMv1@osiris>
Message-ID: <20220114145547.GG16732@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Jan 10, 2022 at 06:26:54PM +0100, Heiko Carstens wrote:
> On Mon, Jan 10, 2022 at 04:23:05PM +0100, Alexander Egorenkov wrote:
> > Heiko Carstens <hca@linux.ibm.com> writes:
> > > Given that Alexander is currently not available, I will resend his
> > > patch with an updated commit message.
> > 
> > Many thanks for the review and taking care of the review finding.
> 
> But it looks like this still hasn't been applied to the kexec-tools
> git tree, unless I'm mistaken(?)

Sorry for the delay, I have now applied v2.

