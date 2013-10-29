Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbAmx-0002vv-1S
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 15:00:59 +0000
In-Reply-To: <20131029085036.GB16009@dhcp-16-126.nay.redhat.com>
References: <20131028094223.GA2335@srcf.ucam.org>
 <20131028095459.GE25527@dhcp-16-126.nay.redhat.com>
 <20131028101256.GA3226@srcf.ucam.org>
 <20131028103412.GG25527@dhcp-16-126.nay.redhat.com>
 <20131028103929.GA4407@srcf.ucam.org>
 <20131028104532.GA29133@dhcp-16-126.nay.redhat.com>
 <20131028105119.GA4822@srcf.ucam.org>
 <20131028105351.GB29133@dhcp-16-126.nay.redhat.com>
 <20131029030521.GE5185@dhcp-16-126.nay.redhat.com>
 <20131029033429.GG5185@dhcp-16-126.nay.redhat.com>
 <20131029085036.GB16009@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 29 Oct 2013 07:57:37 -0700
Message-ID: <698b34fe-77c0-4924-bc10-b713f46b5f46@email.android.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, kexec@lists.fedoraproject.org

Seems reasonable to me.

Dave Young <dyoung@redhat.com> wrote:
>On 10/29/13 at 11:34am, Dave Young wrote:
>> On 10/29/13 at 11:05am, Dave Young wrote:
>> > On 10/28/13 at 06:53pm, Dave Young wrote:
>> > > On 10/28/13 at 10:51am, Matthew Garrett wrote:
>> > > > On Mon, Oct 28, 2013 at 06:45:32PM +0800, Dave Young wrote:
>> > > > > On 10/28/13 at 10:39am, Matthew Garrett wrote:
>> > > > > > On Mon, Oct 28, 2013 at 06:34:12PM +0800, Dave Young wrote:
>> > > > > > > On 10/28/13 at 10:12am, Matthew Garrett wrote:
>> > > > > > > > Right, but previously acpi_rsdp was passed
>automatically and now it 
>> > > > > > > > won't be?
>> > > > > > > 
>> > > > > > > Yes, it was. I'm removing them in kexec-tools patches for
>efi runtime support.
>> > > > > > 
>> > > > > > If I upgrade kexec-tools and try to launch an old kernel, I
>now need to 
>> > > > > > add an extra parameter?
>> > > > > 
>> > > > > Yes, it should work by passing the acpi_rsdp= via --append
>> > > > 
>> > > > Yes, that's my point. You're breaking old configurations by
>requiring 
>> > > > the user to pass an additional argument.
>> > > 
>> > > Hmm, I will do some test without this patch, if it works well
>it's not
>> > > harmful to drop this one.
>> > 
>> > Removing this patch does not work because in this series efi_info
>is passed into
>> > 2nd kernel thus 2nd kernel will initilize efi but it does not have
>related code
>> > to handle the converted talbe addresses and it will endter virtual
>mode again. 
>> > 
>> > I will think about how to solve this problem.
>> > 
>> 
>> The only way what I can think out is introduce a flag in x86 setup
>header.
>> Will try this way, the userspace code will use old logic if the
>kernel is old.
>
>Firstly I want to ask opinion from HPA, what do you think about adding
>a flag to
>xloadflags for this purpose?

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
