Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJAlD-0000xU-80
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 07:24:48 +0000
Received: by mail-wr1-x442.google.com with SMTP id z1so4531875wrt.3
 for <kexec@lists.infradead.org>; Fri, 18 Sep 2020 00:24:45 -0700 (PDT)
Subject: Re: [PATCH] arm64: Add purgatory printing
References: <20200917193835.30910-1-matthias.bgg@kernel.org>
 <fd2910d9-7268-3b8a-465a-3a7406dd0cd8@infradead.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c470b06c-4470-2175-f96e-e98c27352c20@gmail.com>
Date: Fri, 18 Sep 2020 09:24:42 +0200
MIME-Version: 1.0
In-Reply-To: <fd2910d9-7268-3b8a-465a-3a7406dd0cd8@infradead.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>, matthias.bgg@kernel.org, kexec@lists.infradead.org, horms@verge.net.au
Cc: Matthias Brugger <mbrugger@suse.com>

Hi Geoff,

On 18/09/2020 04:04, Geoff Levand wrote:
> Hi Matthias,
> 
> On 9/17/20 12:38 PM, matthias.bgg@kernel.org wrote:
> Add option to allow purgatory printing on arm64 hardware
>> by passing the console name which should be used.
> 
>> +static uint64_t find_purgatory_sink(const char *console)
>> +{
>> +	int fd, ret;
>> +	char folder[255], device[255], mem[255];
>> +	struct stat sb;
>> +	char buffer[18];
>> +	uint64_t iomem = 0x0;
>> +
>> +	if (!console)
>> +		return 0;
>> +
>> +	sprintf(device, "/sys/class/tty/%s", console);
>> +	if (!stat(folder, &sb) == 0 && S_ISDIR(sb.st_mode)) {
>> +		fprintf(stderr, "kexec: %s: No valid console found for %s\n",
>> +			__func__, device);
>> +		return 0;
>> +	}
>> +
>> +	sprintf(mem, "%s%s", device, "/iomem_base");
>> +	printf("console memory read from %s\n", mem);
>> +
>> +	fd = open(mem, O_RDONLY);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "kexec: %s: No able to open %s\n",
>> +			__func__, mem);
>> +		return 0;
>> +	}
>> +
>> +	memset(buffer, '\0', sizeof(char) * 18);
> 
> I think I'd like to just see 'memset(buffer, 0, sizeof(buffer));'.
> 
>> +	ret = read(fd, buffer, 18);
> 
> And 'ret = read(fd, buffer, sizeof(buffer));'.
> 

You are correct, I'll add it to v2.

Thanks for the quick review!

Matthias

>> +	if (ret < 0) {
>> +		fprintf(stderr, "kexec: %s: not able to read fd\n", __func__);
>> +		close(fd);
>> +		return 0;
>> +	}
>> +
>> +	sscanf(buffer, "%lx", &iomem);
>> +	printf("console memory is at %#lx\n", iomem);
>> +
>> +	close(fd);
>> +	return iomem;
>> +}
>> +
> 
> Otherwise, looks OK.
> 
> -Geoff
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
