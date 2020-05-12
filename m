Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYYrl-0007Z7-R9
 for kexec@lists.infradead.org; Tue, 12 May 2020 17:38:55 +0000
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [REQUEST] makedumpfile: stream compress flat ELF format with libz
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20200512172546.GL31850@zorba>
Date: Tue, 12 May 2020 12:38:42 -0500
Message-Id: <69649640-B477-4969-AA2B-2E03587944F1@oracle.com>
References: <20200512172546.GL31850@zorba>
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
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>



> On May 12, 2020, at 12:25 PM, Daniel Walker (danielwa) <danielwa@cisco.com> wrote:
> 
> 
> Hi,
> 
> I created an enhancement request for makedumpfile here,
> 
> https://urldefense.com/v3/__https://github.com/makedumpfile/makedumpfile/issues/1__;!!GqivPVa7Brio!LJIWfQ8ged-9RjjV00zqmBGbL2-UU0baDJmxqVXo5AxYcofHzP8oxfWHZZ4ijk6O9N9I$ 
> 
> I found that compressing a flat core with gzip significantly reduces the size of
> the core. Here were my findings,
> 
> 32G flat elf core -E -F -d 0
> 33G kdump core -d 0
> 16G kdump compressed -c -d 0
> 1.9G flat elf core stream compressed with gzip -E -F -d 0
> 
> My feature request was to implement an option inside makedumpfile to gzip
> compress the core output. This can already be accomplished by piping the core
> thru the gzip tool, however, because makedumpfile already links against libz
> having the option for makedumpfile to do it allows the gzip tools to be removed
> from the crash kernels initramfs there by reducing the size.
> 
> Kazuhito Hagio had suggest adding the -C option instead of repurposing -c to do
> this.
> 


  Hi Daniel. 

   -z happens to be used by tar and rsync to indicate compression ;-) . 





> So a resulting command line might looks like this,
> 
> makedumpfile -C -F -E -d 31 /proc/vmcore core.gz
> 
> Thanks,
> Daniel
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/kexec__;!!GqivPVa7Brio!LJIWfQ8ged-9RjjV00zqmBGbL2-UU0baDJmxqVXo5AxYcofHzP8oxfWHZZ4ijsPXKz5A$ 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
